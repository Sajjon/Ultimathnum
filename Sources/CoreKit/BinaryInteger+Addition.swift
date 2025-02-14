//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer x Addition
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the trapping result of `lhs + rhs`.
    @inlinable public static func +(lhs: consuming Self, rhs: borrowing Self) -> Self {
        lhs.plus(rhs).unwrap()
    }
    
    /// Returns the wrapping result of `lhs + rhs`.
    @inlinable public static func &+(lhs: consuming Self, rhs: borrowing Self) -> Self {
        lhs.plus(rhs).value
    }
    
    /// Forms the trapping result of `lhs + rhs`.
    @inlinable public static func +=(lhs: inout Self, rhs: borrowing Self) {
        lhs = lhs + rhs
    }
    
    /// Forms the wrapping result of `lhs + rhs`.
    @inlinable public static func &+=(lhs: inout Self, rhs: borrowing Self) {
        lhs = lhs &+ rhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// The next value in arithmetic progression.
    @inlinable public consuming func incremented() -> Fallible<Self> {
        self.plus(true)
    }
    
    /// Returns the result of `self + increment`.
    @inlinable public consuming func plus(_ increment: Bool) -> Fallible<Self> {
        switch Self.isSigned {
        case true : self.minus(Self(repeating: Bit(increment)))
        case false: self.plus (Self(/*------*/ Bit(increment)))
        }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Fallible
//=----------------------------------------------------------------------------=

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the result of `self + increment` that fits.
    @inlinable public consuming func plus(_ increment: borrowing Fallible<Self>) -> Fallible<Self> {
        self.plus(increment.value).veto(increment.error)
    }
}

//*============================================================================*
// MARK: * Binary Integer x Addition x Systems
//*============================================================================*

extension SystemsInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Composition
    //=------------------------------------------------------------------------=
    
    /// Returns the result of `self` + (`other` + `bit`).
    @inlinable public consuming func plus(_ other: borrowing Self, plus bit: Bool) -> Fallible<Self> {
        let a: Bool, b: Bool
        
        (self, a) = self.plus(other).components()
        (self, b) = self.plus((bit)).components()
        
        return self.veto(a != b)
    }
}
