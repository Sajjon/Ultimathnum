//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import CoreKit

//*============================================================================*
// MARK: * Minimi Int x Subtraction
//*============================================================================*

extension MinimiInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func negated() -> Fallible<Self> {
        Fallible(self, error: Bool(bitPattern: self))
    }
    
    @inlinable public func minus( _ decrement: Self) -> Fallible<Self> {
        Fallible(self ^ decrement, error: Bool(bitPattern: self.base < decrement.base))
    }
}
