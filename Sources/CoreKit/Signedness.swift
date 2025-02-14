//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Signedness
//*============================================================================*

public protocol Signedness {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable var matchesSignedTwosComplementFormat: Bool { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Lookup
//=----------------------------------------------------------------------------=

extension Signedness where Self == Signed {
    @inlinable public static var signed: Self {
        Self()
    }
}

extension Signedness where Self == Unsigned {
    @inlinable public static var unsigned: Self {
        Self()
    }
}
