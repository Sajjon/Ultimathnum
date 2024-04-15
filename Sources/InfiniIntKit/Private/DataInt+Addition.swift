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
// MARK: * Data Int x Addtion
//*============================================================================*

extension DataInt.Canvas {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// ### Development
    ///
    /// Note that it does not return an instance of itself because it may not
    /// actually be computed.
    ///
    @inlinable public consuming func plus(_ bit: consuming Bool, repeating pattern: Bool) -> Bool {
        if  bit != pattern {
            let predicate = copy bit
            let increment = copy bit ? 1 : ~0 as Element
            
            while self.count > 0, copy bit == predicate {
                bit = self.capture {
                    $0.plusSubSequence(increment)
                }
            }
        }
        
        return bit as Bool as Bool as Bool as Bool
    }
}
