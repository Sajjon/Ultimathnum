//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import CoreKit

//*============================================================================*
// MARK: * Signed Int x Subtraction
//*============================================================================*

extension SignedInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func negated() -> Overflow<Self> {
        Overflow(Self(sign: self.sign.toggled(), magnitude: self.magnitude), overflow: false)
    }
    
    @inlinable public consuming func decremented(by decrement: borrowing Self) -> Overflow<Self> {
        self.incremented(by: -decrement)
    }
}
