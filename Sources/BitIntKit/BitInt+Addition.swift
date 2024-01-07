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
// MARK: * Bit Int x Addition x Signed
//*============================================================================*

extension BitInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func incremented(by increment: borrowing Self) -> Overflow<Self> {
        Overflow(Self(bitPattern: (copy self).bitPattern ^ increment.bitPattern), overflow: self & increment != 0)
    }
}

//*============================================================================*
// MARK: * Bit Int x Addition x Unsigned
//*============================================================================*

extension BitInt.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func incremented(by increment: borrowing Self) -> Overflow<Self> {
        Overflow(Self(bitPattern: (copy self).bitPattern ^ increment.bitPattern), overflow: self & increment != 0)
    }
}
