//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Memory Int x Sub Sequence
//*============================================================================*

extension MemoryInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public subscript(range: PartialRangeFrom<UX>) -> Self {
        consuming get {
            let start = Swift.min(range.lowerBound, UX(bitPattern: self.body.count))
            return Self(self.body[unchecked: start...], repeating: self.appendix)
        }
    }
}

//*============================================================================*
// MARK: * Memory Int x Sub Sequence x Body
//*============================================================================*

extension MemoryInt.Body {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public subscript(unchecked range: PartialRangeFrom<UX>) -> Self {
        consuming get {
            //=----------------------------------=
            Swift.assert(range.lowerBound <= self.count, String.indexOutOfBounds())
            //=----------------------------------=
            let start = self.start.advanced(by: Int(bitPattern:  range.lowerBound))
            let count = self.count.minus(IX(bitPattern: range.lowerBound)).assert()
            return Self(start, count: count)
        }
    }
}
