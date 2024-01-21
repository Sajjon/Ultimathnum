//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Bit
//*============================================================================*

@frozen public struct Bit: BitCastable, BitOperable, Comparable, Hashable, ExpressibleByIntegerLiteral {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    public let bitPattern: Bool
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(bitPattern: Bool) {
        self.bitPattern = bitPattern
    }

    @inlinable public init(integerLiteral: Swift.Int.IntegerLiteralType) {
        if  integerLiteral == 0 {
            self.bitPattern = false
        }   else if integerLiteral == 1 {
            self.bitPattern = true
        }   else {
            fatalError(.overflow())
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func ~(instance: consuming Self) -> Self {
        Self(bitPattern: !instance.bitPattern)
    }
    
    @inlinable public static func &(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.bitPattern == rhs.bitPattern ? lhs.bitPattern : false)
    }
    
    @inlinable public static func |(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.bitPattern == rhs.bitPattern ? lhs.bitPattern : true )
    }
    
    @inlinable public static func ^(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.bitPattern != rhs.bitPattern)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func compared(to other: Self) -> Signum {
        self == other ? 0 : self < other ? -1 : 1
    }
    
    @inlinable public static func ==(lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.bitPattern == rhs.bitPattern
    }
    
    @inlinable public static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        (lhs.bitPattern, rhs.bitPattern) == (false, true)
    }
    
    //*========================================================================*
    // MARK: * Selection
    //*========================================================================*
    
    @frozen public enum Selection {
        case all
        case ascending
        case descending
    }
}
