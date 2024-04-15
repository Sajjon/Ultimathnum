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
// MARK: * Triplet x Subtraction
//*============================================================================*

extension Triplet {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 3 by 2
    //=------------------------------------------------------------------------=
    
    @inlinable package consuming func minus(_ increment: borrowing Doublet<Base>) -> Fallible<Self> {
        let appendix = High(repeating: increment.high.appendix)
        let low  = self.low .minus(increment.low)
        let mid  = self.mid .minus(Mid(bitPattern:  increment.high), and: low.error)
        let high = self.high.minus(appendix,  and:  mid.error)
        return Self(low: low.value, mid: mid.value, high: high.value).combine(high.error)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 3 by 3
    //=------------------------------------------------------------------------=
    
    @inlinable package consuming func minus(_ increment: borrowing Self) -> Fallible<Self> {
        let low  = self.low .minus(increment.low)
        let mid  = self.mid .minus(increment.mid,   and:  low.error)
        let high = self.high.minus(increment.high,  and:  mid.error)
        return Self(low: low.value, mid: mid.value, high: high.value).combine(high.error)
    }
}
