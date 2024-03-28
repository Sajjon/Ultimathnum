//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Core Int x Subtraction
//*============================================================================*

extension CoreInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func negated() -> ArithmeticResult<Self> {
        let result = (~self).plus(1) as ArithmeticResult<Self>
        return ArithmeticResult(result.value, error: result.error == Self.isSigned)
    }
    
    @inlinable public consuming func minus(_ decrement: borrowing Self) -> ArithmeticResult<Self> {
        let result = self.base.subtractingReportingOverflow(decrement.base)
        return ArithmeticResult(Self(result.partialValue), error: result.overflow)
    }
}
