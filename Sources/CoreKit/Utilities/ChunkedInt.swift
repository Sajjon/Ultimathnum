//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Chunked Int
//*============================================================================*

/// A sequence that chunks elements of an un/signed source.
///
/// ```swift
/// for word: UX in ChunkedInt(source, isSigned: false, count: nil) { ... }
/// for byte: U8 in ChunkedInt(source, isSigned: false, count: nil) { ... }
/// ```
///
/// ### Bit Sequence
///
/// You can create a bit sequence by chunking as `BitInt.Magnitude`.
///
/// ```swift
/// for bit: U1 in ChunkedInt(normalizing: base, isSigned: false).reversed() {
///     double()
///
///     if  bit == 1 {
///         increment()
///     }
/// }
/// ```
///
/// ### Binary Integer Order
///
/// This sequence is ordered like a binary integer, meaning it merges and splits
/// its elements from least significant to most. You can reorder it by reversing
/// the input, the output, or both.
///
/// ```swift
/// [1, 2, 3, 4] == Array(ChunkedInt(([0x0201, 0x0403] as [U16]),            as: U8.self))
/// [2, 1, 4, 3] == Array(ChunkedInt(([0x0201, 0x0403] as [U16]).reversed(), as: U8.self).reversed())
/// [3, 4, 1, 2] == Array(ChunkedInt(([0x0201, 0x0403] as [U16]).reversed(), as: U8.self))
/// [4, 3, 2, 1] == Array(ChunkedInt(([0x0201, 0x0403] as [U16]),            as: U8.self).reversed())
/// ```
///
/// ```swift
/// [0x0201, 0x0403] == Array(ChunkedInt(([1, 2, 3, 4] as [U8]),            as: U16.self))
/// [0x0102, 0x0304] == Array(ChunkedInt(([1, 2, 3, 4] as [U8]).reversed(), as: U16.self).reversed())
/// [0x0403, 0x0201] == Array(ChunkedInt(([1, 2, 3, 4] as [U8]),            as: U16.self).reversed())
/// [0x0304, 0x0102] == Array(ChunkedInt(([1, 2, 3, 4] as [U8]).reversed(), as: U16.self))
/// ```
///
@frozen public struct ChunkedInt<Base, Element>: RandomAccessCollection where
Element: SystemsInteger & UnsignedInteger, Base: RandomAccessCollection, Base.Element: SystemsInteger & UnsignedInteger {
    
    public typealias Base = Base
    
    /// A namespace for Element.bitWidth \> Base.Element.bitWidth.
    @frozen @usableFromInline enum Major { }
    
    /// A namespace for Element.bitWidth \< Base.Element.bitWidth.
    @frozen @usableFromInline enum Minor { }
    
    /// A namespace for Element.bitWidth == Base.Element.bitWidth.
    @frozen @usableFromInline enum Equal { }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    /// The un/signed source.
    public let base: Base
    
    /// The sign extension of the un/signed source.
    public let sign: Element
    
    /// The length of this sequence.
    ///
    /// ### Development
    ///
    /// - TODO: Consider consider deriving the `count` instead (measure it).
    ///
    public let count: Int
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a sequence of the given type from an un/signed source.
    ///
    /// - Parameters:
    ///   - base: The base sequence viewed through this sequence.
    ///   - isSigned: The signedness of the base sequence.
    ///   - count: An optionally chosen number of elements to view.
    ///   - element: The type of element produced by this sequence.
    ///
    @inlinable public init(_ base: Base, isSigned: Bool, count: Int? = nil, as element: Element.Type = Element.self) {
        let isLessThanZero = SBISS.isLessThanZero(base, isSigned: isSigned)
        let count = count ?? Self.count(of: base)
        self.init(base, repeating: Bit(bitPattern: isLessThanZero), count: count)
    }
    
    /// Creates a normalized bit sequence from an un/signed source.
    ///
    /// - Parameters:
    ///   - base: The base sequence viewed through this sequence.
    ///   - isSigned: The signedness of the base sequence.
    ///   - element: The type of element produced by this sequence.
    ///
    @inlinable public init(normalizing base: Base, isSigned: Bool, as element: Element.Type = Element.self) {
        let isLessThanZero = SBISS.isLessThanZero(base, isSigned: isSigned)
        let count = Self.count(normalizing: base, repeating: Bit(bitPattern: isLessThanZero))
        self.init(base, repeating: Bit(bitPattern: isLessThanZero), count: count)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable internal init(_ base: Base, repeating bit: Bit, count: Int, as element: Element.Type = Element.self) {
        self.base  = base
        self.sign  = Self.Element(repeating: bit)
        self.count = count
        precondition(self.count >= 0 as Int)
        Swift.assert(Self.Element.bitWidth.count(1, option: .all) == 1)
        Swift.assert(Base.Element.bitWidth.count(1, option: .all) == 1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable internal static var comparison: Signum {
        Self.Element.bitWidth.load(as: UX.self).compared(to: Base.Element.bitWidth.load(as: UX.self))
    }
    
    @inlinable internal static func count(of base: Base) -> Int {
        switch comparison {
        case Signum.less: return Minor.count(of: base)
        case Signum.same: return Equal.count(of: base)
        case Signum.more: return Major.count(of: base)
        }
    }
    
    @inlinable internal static func count(normalizing base: Base, repeating bit: Bit) -> Int {
        switch comparison {
        case Signum.less: return Minor.count(normalizing: base, repeating: bit)
        case Signum.same: return Equal.count(normalizing: base, repeating: bit)
        case Signum.more: return Major.count(normalizing: base, repeating: bit)
        }
    }
    
    @inlinable internal static func element(_ index: Int, base: Base, sign: Element) -> Element {
        switch comparison {
        case Signum.less: return Minor.element(index, base: base, sign: sign)
        case Signum.same: return Equal.element(index, base: base, sign: sign)
        case Signum.more: return Major.element(index, base: base, sign: sign)
        }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Sendable
//=----------------------------------------------------------------------------=

extension ChunkedInt: Sendable where Base: Sendable { }

//=----------------------------------------------------------------------------=
// MARK: + Major
//=----------------------------------------------------------------------------=

extension ChunkedInt.Major {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static var ratio: Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.more, String.unreachable())
        //=--------------------------------------=
        let major = Element.bitWidth
        let minor = Element.Magnitude(truncating: Base.Element.bitWidth)
        return (major &>> minor.count(0, option: .ascending)).load(as: Int.self)
    }
    
    @inlinable static func count(of base: some Collection<Base.Element>) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.more, String.unreachable())
        //=--------------------------------------=
        let division = base.count.quotientAndRemainder(dividingBy: self.ratio)
        return division.quotient + (division.remainder > 0 ? 1 : 0)
    }
    
    @inlinable static func count(normalizing base: Base, repeating bit: Bit) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.more, String.unreachable())
        //=--------------------------------------=
        let sign = Base.Element(repeating: bit)
        return Swift.max(1, self.count(of: base.reversed().trimmingPrefix(while:{ $0 == sign })))
    }
    
    @inlinable static func element(_ index: Int, base: Base, sign: Element) -> Element {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.more, String.unreachable())
        //=--------------------------------------=
        var major = 0 as Element
        var shift = 0 as Element.Magnitude
        let minor = self.ratio * index
        
        if  minor < base.count {
            var   baseIndex = base.index(base.startIndex, offsetBy: minor)
            while baseIndex < base.endIndex, shift < Element.bitWidth {
                major = major | Element(truncating: Base.Element.Magnitude(bitPattern: base[baseIndex])) &<< Element(bitPattern: shift)
                shift = shift + Element.Magnitude(load: Base.Element.bitWidth.load(as: UX.self))
                base.formIndex(after: &baseIndex)
            }
        }
        
        return shift >= Element.bitWidth ? major : major | sign &<< Element(bitPattern: shift)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Minor
//=----------------------------------------------------------------------------=

extension ChunkedInt.Minor {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static var ratio: Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.less, String.unreachable())
        //=--------------------------------------=
        let major = Base.Element.bitWidth
        let minor = Base.Element.Magnitude(truncating: Element.bitWidth)
        return (major &>> minor.count(0, option: .ascending)).load(as: Int.self)
    }
    
    @inlinable static func count(of base: some Collection<Base.Element>) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.less, String.unreachable())
        //=--------------------------------------=
        return base.count * self.ratio as Int
    }
    
    @inlinable static func count(normalizing base: Base, repeating bit: Bit) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.less, String.unreachable())
        //=--------------------------------------=
        let sign = Base.Element(repeating: bit)
        let majorSuffix = base.reversed().prefix(while:{ $0 == sign })
        let minorSuffix = base.dropLast(majorSuffix.count).last?.count(bit, option: Bit.Selection.descending) ?? (0000)
        let totalSuffix = majorSuffix.count * Base.Element.bitWidth.load(as: Int.self) + minorSuffix.load(as: Int.self)
        return Swift.max(1, self.count(of: base) - totalSuffix / Element.bitWidth.load(as: Int.self))
    }
    
    @inlinable static func element(_ index: Int, base: Base, sign: Element) -> Element {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.less, String.unreachable())
        //=--------------------------------------=
        precondition(index >= 0 as Int, String.indexOutOfBounds())
        let quotient  = index &>> self.ratio.trailingZeroBitCount
        let remainder = index &  (self.ratio &- 1)
        //=--------------------------------------=
        if  quotient >= base.count { return sign }
        //=--------------------------------------=
        let major = base[base.index(base.startIndex, offsetBy: quotient)]
        let shift = Base.Element(load: UX(bitPattern: remainder)) &<< Base.Element(truncating: Element.bitWidth.count(0, option: .ascending))
        return Element(truncating: major &>> shift)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Equal
//=----------------------------------------------------------------------------=

extension ChunkedInt.Equal {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func count(of base: some Collection<Base.Element>) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.same, String.unreachable())
        //=--------------------------------------=
        return base.count as Int as Int as Int
    }
    
    @inlinable static func count(normalizing base: Base, repeating bit: Bit) -> Int {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.same, String.unreachable())
        //=--------------------------------------=
        let sign = Base.Element(repeating: bit)
        return Swift.max(1, self.count(of: base.reversed().trimmingPrefix(while:{ $0 == sign })))
    }
    
    @inlinable static func element(_ index: Int, base: Base, sign: Element) -> Element {
        //=--------------------------------------=
        precondition(ChunkedInt.comparison == Signum.same, String.unreachable())
        //=--------------------------------------=
        if  index >= base.count { return sign }
        //=--------------------------------------=
        return Element(truncating: base[base.index(base.startIndex, offsetBy: index)])
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Collection
//=----------------------------------------------------------------------------=

extension ChunkedInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var startIndex: Int {
        0 as Int
    }
    
    @inlinable public var endIndex: Int {
        self.count
    }
    
    @inlinable public var indices: Range<Int> {
        0 as Int ..< self.count
    }
    
    /// The element at the given index.
    ///
    /// Its elements are ordered from least significant to most, with infinite sign extension.
    ///
    @inlinable public subscript(index: Int) -> Element {
        Self.element(index, base: self.base, sign: self.sign)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func distance(from start: Int, to end: Int) -> Int {
        end - start
    }
    
    @inlinable public func index(after index: Int) -> Int {
        index + 1 as Int
    }
    
    @inlinable public func index(before index: Int) -> Int {
        index - 1 as Int
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int) -> Int {
        index + distance
    }
}
