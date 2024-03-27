//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Unsigned Integer x Numbers
//*============================================================================*

extension UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializeres
    //=------------------------------------------------------------------------=
    
    @inlinable public init(magnitude: consuming Magnitude) {
        self = consume magnitude
    }
    
    @inlinable public var magnitude: Magnitude {
        consuming get { consume self }
    }
}
