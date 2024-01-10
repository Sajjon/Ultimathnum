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
// MARK: * Main Int x Addition
//*============================================================================*

extension MainInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func incremented(by increment: borrowing Self) throws -> Self {
        let result = self.base.addingReportingOverflow(increment.base)
        return try Overflow.resolve(Self(result.partialValue), overflow: result.overflow)
    }
}
