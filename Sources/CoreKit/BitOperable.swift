//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Bit Operable
//*============================================================================*

public protocol BitOperable {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static prefix func ~(operand: consuming Self) -> Self
    
    @inlinable static func &(lhs: consuming Self, rhs: borrowing Self) -> Self
    
    @inlinable static func |(lhs: consuming Self, rhs: borrowing Self) -> Self
    
    @inlinable static func ^(lhs: consuming Self, rhs: borrowing Self) -> Self
}

//=----------------------------------------------------------------------------=
// MARK: + Expressible By Integer Literal
//=----------------------------------------------------------------------------=

extension BitOperable where Self: ExpressibleByIntegerLiteral {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(repeating bit: Bit) {
        self = bit == (0 as Bit) ? (0 as Self) : (~0 as Self)
    }
}
