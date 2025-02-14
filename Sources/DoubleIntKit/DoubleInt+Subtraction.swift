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
// MARK: * Double Int x Subtraction
//*============================================================================*

extension DoubleInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 2 by 1
    //=------------------------------------------------------------------------=
        
    @inlinable public consuming func minus(_ decrement: Base.Magnitude) -> Fallible<Self> {
        let low  = self.low .minus(Low(raw: decrement))
        let high = self.high.minus(low.error)
        return Self(low: low.value, high: high.value).veto(high.error)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 2 by 2
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func minus(_ decrement: borrowing Self) -> Fallible<Self> {
        let low  = self.storage.low .minus(decrement.storage.low)
        let high = self.storage.high.minus(decrement.storage.high, plus: low.error)
        return Self(low: low.value, high: high.value).veto(high.error)
    }
}
