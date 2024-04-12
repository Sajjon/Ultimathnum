//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Memory Int x Normalization
//*============================================================================*

extension MemoryInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func normalized() -> Self {
        Self(self.body.normalized(repeating: self.appendix), repeating: self.appendix)
    }
}

//*============================================================================*
// MARK: * Memory Int x Normalization x Body
//*============================================================================*

extension MemoryInt.Body {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func normalized(repeating appendix: Bit) -> Self {
        let appendix = Element(repeating: appendix)
        var endIndex = self.count
        
        while endIndex > 0 {
            let lastIndex = endIndex.minus(1).assert()
            guard self[unchecked: lastIndex] == appendix else { break }
            endIndex = lastIndex
        }
        
        return Self(self.start, count: endIndex)
    }
}
