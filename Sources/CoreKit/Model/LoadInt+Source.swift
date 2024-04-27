//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Load Int x Source
//*============================================================================*

extension LoadInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    #warning("the body() name was better...")
    @inlinable public func source() -> Prefix {
        let ratio = UX(bitPattern: MemoryLayout<Element>.stride)
        var major = UX(bitPattern: self.base.body.count)
        major  &>>= UX(bitPattern: ratio.count(0, where: Bit.Selection.ascending))
        var minor = UX(bitPattern: self.base.body.count)
        minor    &= UX(bitPattern: ratio.minus(1).assert())
        return self.prefix(major.plus(UX(Bit(minor != 0))).assert())
    }
}
