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
// MARK: * Double Int x Multiplication
//*============================================================================*

extension DoubleInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func squared() -> Fallible<Self> {
        self.times(copy self)
    }
    
    @inlinable public consuming func times(_ multiplier: Self) -> Fallible<Self> {
        Fallible(bitPattern: self.storage.times(multiplier.storage))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Composition
    //=------------------------------------------------------------------------=
    
    @inlinable public func multiplication(_ multiplier: Self) -> Doublet<Self> {
        let minus  = self.high.isLessThanZero != multiplier.high.isLessThanZero
        let result: Doublet<Magnitude> = self.magnitude().multiplication(multiplier.magnitude())
        return Doublet(bitPattern: minus ? result.complement() : result)
    }
}

//*============================================================================*
// MARK: * Double Int x Multiplication x Unsigned
//*============================================================================*

extension DoubleInt where Base == Base.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Composition
    //=------------------------------------------------------------------------=
    
    @inlinable func multiplication(_ multiplier: Self) -> Doublet<Self> {
        var ax = self.low .multiplication(multiplier.low )
        let ay = self.low .multiplication(multiplier.high)
        let bx = self.high.multiplication(multiplier.low )
        var by = self.high.multiplication(multiplier.high)
        //=--------------------------------------=
        let a0 = ax.high[{ $0.plus(ay.low ) }]
        let a1 = ax.high[{ $0.plus(bx.low ) }]
        let a2 = Low(Bit(a0)) &+  Low(Bit(a1))
        //=--------------------------------------=
        let b0 = by.low [{ $0.plus(ay.high) }]
        let b1 = by.low [{ $0.plus(bx.high) }]
        let b2 = Low(Bit(b0)) &+  Low(Bit(b1))
        //=--------------------------------------=
        by = by.plus(Storage(low: a2, high: b2)).assert()
        //=--------------------------------------=
        return Doublet(low: Magnitude(ax), high: Magnitude(by))
    }
}
