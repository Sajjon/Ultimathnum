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
// MARK: * Triplet x Addition
//*============================================================================*

extension Triplet {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 3 by 2
    //=------------------------------------------------------------------------=
    
    @inlinable package consuming func plus(_ increment: borrowing Doublet<Base>) -> Fallible<Self> {
        let appendix = High(repeating: increment.high.appendix)
        let low  = self.low .plus(increment.low)
        let mid  = self.mid .plus(Mid(bitPattern: increment.high), plus: low.error)
        let high = self.high.plus(appendix, plus: mid.error)
        return Self(low: low.value, mid: mid.value, high: high.value).combine(high.error)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 3 by 3
    //=------------------------------------------------------------------------=
    
    @inlinable package consuming func plus(_ increment: borrowing Self) -> Fallible<Self> {
        let low  = self.low .plus(increment.low)
        let mid  = self.mid .plus(increment.mid,  plus: low.error)
        let high = self.high.plus(increment.high, plus: mid.error)
        return Self(low: low.value, mid: mid.value, high: high.value).combine(high.error)
    }
}
