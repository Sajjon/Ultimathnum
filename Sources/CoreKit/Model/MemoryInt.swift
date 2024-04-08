//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Memory Int
//*============================================================================*

@frozen public struct MemoryInt {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let body: Body
    @usableFromInline let appendix: Bit
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ body: Body, repeating appendix: Bit) {
        self.body = body
        self.appendix = appendix
    }
    
    //*========================================================================*
    // MARK: * Body
    //*========================================================================*
    
    @frozen public struct Body {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        public let start: UnsafeRawPointer
        public let count: IX
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable public init(_ start: UnsafeRawPointer, count: IX) {
            self.start = start
            self.count = count
        }
    }
}
