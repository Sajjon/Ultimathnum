//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Double Int Layout x Multiplication x Unsigned
//*============================================================================*

extension DoubleIntLayout {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func multiplication(_ multiplier: Base) -> TripleIntLayout<Base> {
        let lhsIsLessThanZero: Bool = (self.high .isLessThanZero)
        let rhsIsLessThanZero: Bool = (multiplier.isLessThanZero)
        let minus: Bool = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        let product: TripleIntLayout<Base> = { ab, x in
            
            let ax = ab.low .multiplication(x)
            let bx = ab.high.multiplication(x)
            return TripleIntLayout(low: ax.low, high: DoubleIntLayout(bitPattern: bx.plus(ax.high).assert()))
            
        }(self.magnitude, multiplier.magnitude)
        //=--------------------------------------=
        return minus ? product.negated().value : product
    }
}
