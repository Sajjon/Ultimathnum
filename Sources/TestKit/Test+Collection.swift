//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import CoreKit
import XCTest

//*============================================================================*
// MARK: * Test x Collection
//*============================================================================*

extension Test {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    public func collection<Element>(
        _ base: some RandomAccessCollection<Element>, 
        _ expectation: [Element]
    )   where Element: Equatable {
        for distance in 0 ..< base.count {
            let index0 = base.index(base.startIndex, offsetBy: distance + 0)
            let index1 = base.index(base.startIndex, offsetBy: distance + 1)
            
            same(base[index0], expectation[distance])
            
            same(base.index(before: index1), index0)
            same(base.index(after:  index0), index1)

            same(base.index(base.endIndex, offsetBy: distance + 0 - base.count), index0)
            same(base.index(base.endIndex, offsetBy: distance + 1 - base.count), index1)
            
            same(base.distance(from: base.startIndex, to: index0), distance + 0)
            same(base.distance(from: base.startIndex, to: index1), distance + 1)
            
            same(base.distance(from: index0, to: base.endIndex), base.count - distance - 0)
            same(base.distance(from: index1, to: base.endIndex), base.count - distance - 1)
        }
    }
}
