//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import UMNCoreKit

//*============================================================================*
// MARK: * UNM x Signed Int x Division
//*============================================================================*

extension UMNSignedInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func quotient (divisor: borrowing Self) -> UMNOverflow<Self> {
        UMNOverflow(sign: self.sign ^ divisor.sign, magnitude: self.magnitude.quotient(divisor: divisor.magnitude))
    }
    
    @inlinable public consuming func remainder(divisor: borrowing Self) -> UMNOverflow<Self> {
        UMNOverflow(sign: self.sign, magnitude: self.magnitude.remainder(divisor: divisor.magnitude))
    }
    
    @inlinable public consuming func divided(by divisor: borrowing Self) -> UMNOverflow<UMNQuoRem<Self, Self>> {
        let magnitude = self.magnitude.divided(by: divisor.magnitude)
        let quotient  = Self(sign: self.sign ^ divisor.sign, magnitude: magnitude.value.quotient )
        let remainder = Self(sign: self.sign   /*--------*/, magnitude: magnitude.value.remainder)
        return UMNOverflow(UMNQuoRem(quotient: quotient, remainder: remainder), overflow: magnitude.overflow)
    }
}
