//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Int
//*============================================================================*

extension Int: BaseInteger {
    @inlinable public var bitPattern: Magnitude {
        Magnitude(bitPattern: self)
    }
}

extension Int8: BaseInteger {
    @inlinable public var bitPattern: Magnitude {
        Magnitude(bitPattern: self)
    }
}

extension Int16: BaseInteger {
    @inlinable public var bitPattern: Magnitude {
        Magnitude(bitPattern: self)
    }
}

extension Int32: BaseInteger {
    @inlinable public var bitPattern: Magnitude {
        Magnitude(bitPattern: self)
    }
}

extension Int64: BaseInteger {
    @inlinable public var bitPattern: Magnitude {
        Magnitude(bitPattern: self)
    }
}
