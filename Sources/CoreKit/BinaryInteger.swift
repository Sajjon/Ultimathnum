//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer
//*============================================================================*

/// A binary integer.
///
/// ### Binary
///
/// Its signedness is with respect to un/signed two's complement.
///
/// - Requires: Negative values must use binary two's complement form.
///
/// ### Magnitude
///
/// Its magnitude may be signed to accomodate lone big integers.
///
/// ### Stride
///
/// Its stride is Swift.Int which is used to step through Swift's ranges.
///
public protocol BinaryInteger: BitCastable, BitOperable, Comparable, 
ExpressibleByIntegerLiteral, Hashable, Sendable, Strideable, _MaybeLosslessStringConvertible where
Magnitude.BitPattern == BitPattern, Magnitude.Element == Element.Magnitude, Stride == Swift.Int {
    
    associatedtype Content: RandomAccessCollection<Element.Magnitude>
    
    associatedtype Element: SystemsInteger where Element.Element == Element
        
    associatedtype Magnitude: UnsignedInteger where Magnitude.Magnitude == Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: Meta Data
    //=------------------------------------------------------------------------=
    
    /// Indicates whether this type can represent negative values.
    ///
    /// ```
    /// ┌──────┬──────────┬─────┬─────┐
    /// │ type │ isSigned │ min │ max │
    /// ├──────┼──────────┼─────┼─────┤
    /// │ I1   │ true     │ -1  │   0 │
    /// │ U1   │ false    │  0  │  -1 │
    /// └──────┴──────────┴─────┴─────┘
    /// ```
    ///
    @inlinable static var isSigned: Bool { get }
    
    /// The bit width of this type.
    ///
    /// ```
    /// ┌──────┬───────────────────┐
    /// │ type │ bitWidth          │
    /// ├──────┼───────────────────┤
    /// │ I64  │ U64(repeating: 1) │ // 64
    /// │ IXL  │ UXL(repeating: 1) │ // infinite
    /// └──────┴───────────────────┘
    /// ```
    ///
    @inlinable static var bitWidth: Magnitude { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(load source: inout ExchangeInt<T, Element>.BitPattern.Stream)
    
    /// ### Development
    ///
    /// - TODO: Consider whether it is needed.
    ///
    @inlinable init<T>(load source: T) where T: SystemsInteger<Element.BitPattern>
    
    /// ### Development
    ///
    /// - TODO: Consider whether it is needed.
    ///
    @inlinable func load<T>(as type: T.Type) -> T where T: SystemsInteger<Element.BitPattern>
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable consuming func plus (_ increment: borrowing Self) -> ArithmeticResult<Self>
        
    @inlinable consuming func minus(_ decrement: borrowing Self) -> ArithmeticResult<Self>
    
    @inlinable consuming func negated() -> ArithmeticResult<Self>
        
    @inlinable consuming func times(_ multiplier: borrowing Self) -> ArithmeticResult<Self>
    
    @inlinable consuming func squared() -> ArithmeticResult<Self>
    
    /// ### Examples
    ///
    /// ```
    /// ┌──────────┬──────── → ─────────┬───────────┬──────────┐
    /// │ dividend │ divisor │ quotient | remainder │ overflow │
    /// ├──────────┼──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │ I8( 7)   │ I8(-3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8( 3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8(-3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │──────────┤──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 0)  │ I8( 0)   │ I8( 7)    │ true     │
    /// │ I8.min   │ I8(-1)  │ I8.min   │ I8( 0)    │ true     │
    /// └──────────┴──────── → ─────────┴───────────┴──────────┘
    /// ```
    ///
    @inlinable consuming func quotient ( divisor: borrowing Self) -> ArithmeticResult<Self>
    
    /// ### Examples
    ///
    /// ```
    /// ┌──────────┬──────── → ─────────┬───────────┬──────────┐
    /// │ dividend │ divisor │ quotient | remainder │ overflow │
    /// ├──────────┼──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │ I8( 7)   │ I8(-3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8( 3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8(-3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │──────────┤──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 0)  │ I8( 0)   │ I8( 7)    │ true     │
    /// │ I8.min   │ I8(-1)  │ I8.min   │ I8( 0)    │ true     │
    /// └──────────┴──────── → ─────────┴───────────┴──────────┘
    /// ```
    ///
    @inlinable consuming func remainder( divisor: borrowing Self) -> ArithmeticResult<Self>
    
    /// ### Examples
    ///
    /// ```
    /// ┌──────────┬──────── → ─────────┬───────────┬──────────┐
    /// │ dividend │ divisor │ quotient | remainder │ overflow │
    /// ├──────────┼──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │ I8( 7)   │ I8(-3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8( 3)  │ I8(-2)   │ I8(-1)    │ false    │
    /// │ I8(-7)   │ I8(-3)  │ I8( 2)   │ I8( 0)    │ false    │
    /// │──────────┤──────── → ─────────┤───────────┤──────────┤
    /// │ I8( 7)   │ I8( 0)  │ I8( 0)   │ I8( 7)    │ true     │
    /// │ I8.min   │ I8(-1)  │ I8.min   │ I8( 0)    │ true     │
    /// └──────────┴──────── → ─────────┴───────────┴──────────┘
    /// ```
    ///
    @inlinable consuming func divided(by divisor: borrowing Self) -> ArithmeticResult<Division<Self, Self>>
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func  <<(instance: consuming Self, shift: borrowing Self) -> Self
    
    @inlinable static func &<<(instance: consuming Self, shift: borrowing Self) -> Self
    
    @inlinable static func  >>(instance: consuming Self, shift: borrowing Self) -> Self
    
    @inlinable static func &>>(instance: consuming Self, shift: borrowing Self) -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// The bit that may extend the bit pattern of this instance.
    ///
    /// If this value is `signed`, then the `appendix` is `1` for `negative`
    /// values and `0` otherwise. If this value is `unsigned`, then the `appendix`
    /// is `1` for `infinite` values and `0` otherwise.
    ///
    /// ### Development
    ///
    /// This requirement is an alternative to a static `isInfinite` value. One
    /// can derive the other, so it is a design choice. See:
    ///
    /// ```swift
    /// @inlinable public static var isInfinite: Bool {
    ///     Self.bitWidth.appendix == 1
    /// }
    /// ```
    ///
    /// ```swift
    /// @inlnable public var appendix: Bit {
    ///     Bit(bitPattern: (Self.isSigned || Self.isInfinite) && self.count(0, option: .descending) == 0)
    /// }
    /// ```
    ///
    @inlinable var appendix: Bit { get }
    
    @inlinable var content: Content { get }
    
    @inlinable var magnitude: Magnitude { consuming get }
    
    @inlinable borrowing func compared(to other: borrowing Self) -> Signum
    
    @inlinable borrowing func count(_ bit: Bit, option: BitSelection) -> Magnitude
}
