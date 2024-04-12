//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer x Comparison
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Meta Data
    //=------------------------------------------------------------------------=
    
    /// Indicates whether this type can represent all bit patterns.
    @inlinable public var isInfinite: Bool {
        !Self.isSigned && Bool(self.appendix)
    }
    
    /// Indicates whether this type can represent negative values.
    ///
    /// ```
    /// ┌──────┬──────────┬──────┬──────┐
    /// │ type │ isSigned │  min │  max │
    /// ├──────┼──────────┼──────┼──────┤
    /// │ I8   │ true     │ -128 │  127 │
    /// │ U8   │ false    │    0 │  255 │
    /// └──────┴──────────┴──────┴──────┘
    /// ```
    ///
    @inlinable public static var isSigned: Bool {
        Self.mode.isSigned
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public borrowing func signum() -> Signum {
        self.compared(to: 0)
    }
    
    /// Returns whether this value is less than zero.
    ///
    /// It checks `isSigned` first which is preferred in inlinable generic code.
    ///
    @inlinable public var isLessThanZero: Bool {
        Self.isSigned && Bool(self.appendix)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Generic
//=----------------------------------------------------------------------------=

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func ==<Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger {
        lhs.compared(to: rhs) == Signum.same
    }
    
    @inlinable public static func !=<Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger  {
        lhs.compared(to: rhs) != Signum.same
    }
    
    @inlinable public static func < <Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger {
        lhs.compared(to: rhs) == Signum.less
    }
    
    @inlinable public static func >=<Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger  {
        lhs.compared(to: rhs) != Signum.less
    }
    
    @inlinable public static func > <Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger  {
        lhs.compared(to: rhs) == Signum.more
    }
    
    @inlinable public static func <=<Other>(lhs: Self, rhs: Other) -> Bool where Other: BinaryInteger  {
        lhs.compared(to: rhs) != Signum.more
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func compared<Other>(to other: Other) -> Signum where Other: BinaryInteger {
        if !Self.size.isInfinite, !Other.size.isInfinite {
            
            if  UX(load: Self.size) < UX(load: Other.size) {
                return Other(load: self).compared(to: other)
                
            }   else if UX(load: Self.size) > UX(load: Other.size) {
                return self.compared(to: Self(load: other))
                
            }   else if Self.isSigned, !Other.isSigned {
                return self .isLessThanZero ? Signum.less : Other(load: self).compared(to: other)
                
            }   else if !Self.isSigned, Other.isSigned {
                return other.isLessThanZero ? Signum.more : self.compared(to: Self(load:  other))
                
            }   else {
                return self.compared(to: Self(load: other))
            }
            
        }   else {
            
            if Other.elementsCanBeRebound(to: Self.Element.Magnitude.self) {
                return self.withUnsafeBinaryIntegerElements { lhs in
                    (other).withUnsafeBinaryIntegerElements(as: Self.Element.Magnitude.self) { rhs in
                        MemoryInt.compare(
                            lhs: lhs, lhsIsSigned: Self .isSigned,
                            rhs: rhs, rhsIsSigned: Other.isSigned
                        )
                    }!
                }
                
            }   else if Self.elementsCanBeRebound(to: Other.Element.Magnitude.self) {
                return self.withUnsafeBinaryIntegerElements(as: Other.Element.Magnitude.self) { lhs in
                    (other).withUnsafeBinaryIntegerElements { rhs in
                        MemoryInt.compare(
                            lhs: lhs, lhsIsSigned: Self .isSigned,
                            rhs: rhs, rhsIsSigned: Other.isSigned
                        )
                    }
                }!
                
            }   else {
                Swift.fatalError("invalid binary integer invoked BinaryInteger/compared(to:)")
                
            }
        }
    }
}
