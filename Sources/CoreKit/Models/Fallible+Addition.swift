//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Fallible x Addition
//*============================================================================*

extension Fallible where Value: BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func plus(_ other: borrowing Value) -> Self {
        self.value.plus(other).veto(self.error)
    }
    
    @inlinable public consuming func plus(_ other: borrowing Fallible<Value>) -> Self {
        self.value.plus(other).veto(self.error)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Stride by 1
//=----------------------------------------------------------------------------=

extension Fallible where Value: BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the next value in arithmetic progression.
    @inlinable public consuming func incremented() -> Fallible<Value> {
        self.plus(true)
    }
    
    /// Returns the result of `self + increment`.
    @inlinable public consuming func plus(_ increment: Bool) -> Fallible<Value> {
        self.value.plus(increment).veto(self.error)
    }
}
