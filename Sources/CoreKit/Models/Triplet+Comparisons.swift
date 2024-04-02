//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Triplet x Comparison
//*============================================================================*

extension Triplet {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var isLessThanZero: Bool {
        self.high.isLessThanZero
    }
    
    @inlinable public static func ==(lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.compared(to: rhs) == Signum.same
    }
    
    @inlinable public static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.compared(to: rhs) == Signum.less
    }
    
    @inlinable public borrowing func compared(to other: borrowing Self) -> Signum {
        let a = self.high.compared(to: other.high); if a != Signum.same { return a }
        let b = self.mid .compared(to: other.mid ); if b != Signum.same { return b }
        return  self.low .compared(to: other.low );
    }
}
