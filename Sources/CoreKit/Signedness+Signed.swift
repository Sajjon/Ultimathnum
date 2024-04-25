//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Signed
//*============================================================================*

@frozen public struct Signed: Signedness {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
        
    @inlinable public init() {
        
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var isSigned: Bool {
        true
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Lookup
//=----------------------------------------------------------------------------=

extension Signedness where Self == Signed {
    @inlinable public static var signed: Self {
        Self()
    }
}
