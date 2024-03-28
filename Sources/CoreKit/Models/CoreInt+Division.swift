//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Core Int x Division
//*============================================================================*

extension CoreInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func quotient(divisor: borrowing Self) -> ArithmeticResult<Self> {
        let result = self.base.dividedReportingOverflow(by: divisor.base)
        return ArithmeticResult(Self(result.partialValue), error: result.overflow)
    }
    
    @inlinable public consuming func remainder(divisor: Self) -> ArithmeticResult<Self> {
        let result = self.base.remainderReportingOverflow(dividingBy: divisor.base)
        return ArithmeticResult(Self(result.partialValue), error: result.overflow)
    }
    
    @inlinable public consuming func divided(by divisor: Self) -> ArithmeticResult<Division<Self, Self>> {
        let quotient  = (copy    self).quotient (divisor: divisor)
        let remainder = (consume self).remainder(divisor: divisor)
        return ArithmeticResult(Division(quotient: quotient.value, remainder: remainder.value), error: quotient.error || remainder.error)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x 2 vs 1
    //=------------------------------------------------------------------------=
    
    @inlinable public static func dividing(_ dividend: consuming DoubleIntLayout<Self>, by divisor: Self) -> ArithmeticResult<Division<Self, Self>> {
        typealias T = ArithmeticResult<Division<Self, Self>>
        //=--------------------------------------=
        let lhsIsLessThanZero = dividend.high/**/.isLessThanZero
        let rhsIsLessThanZero = divisor/*------*/.isLessThanZero
        let minus: Bool = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var result = T(bitPattern: Magnitude._dividing(TBI.magnitude(of: dividend), by: divisor.magnitude))
        //=--------------------------------------=
        if  minus {
            result.value.quotient .capture({ $0.negated().value })
        }
        
        if  lhsIsLessThanZero {
            result.value.remainder.capture({ $0.negated().value })
        }
        
        let overflow = minus != result.value.quotient.isLessThanZero && !(minus && result.value.quotient == 0)
        //=--------------------------------------=
        return result.combine(overflow)
    }
}

//*============================================================================*
// MARK: * Core Int x Division x Unsigned
//*============================================================================*

extension CoreInt where Self == Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inline(__always) @inlinable static func _dividing(_ dividend: consuming DoubleIntLayout<Self>, by divisor: borrowing Self) -> ArithmeticResult<Division<Self, Self>> {
        //=--------------------------------------=
        if  divisor == 0 {
            return ArithmeticResult.failure(Division(quotient: 0, remainder: dividend.low))
        }
        //=--------------------------------------=
        var overflow = false
        //=--------------------------------------=
        if  divisor <= dividend.high {
            overflow = true
            dividend.high = dividend.high.remainder(divisor: divisor).assert()
        }
        //=--------------------------------------=
        let result = divisor.base.dividingFullWidth((high: dividend.high.base, low: dividend.low.base))
        return ArithmeticResult(Division(quotient: Self(result.quotient), remainder: Self(result.remainder)), error: overflow)
    }
}
