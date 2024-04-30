//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import CoreKit
import TestKit

//*============================================================================*
// MARK: * Doublet
//*============================================================================*

final class DoubletTests: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        func whereTheBaseIs<B>(_ type: B.Type) where B: SystemsInteger {
            typealias T = Doublet<B>
            
            Test().same(T(low: 1, high: 2).low,  1 as B.Magnitude)
            Test().same(T(low: 1, high: 2).high, 2 as B)
            
            Test().same(T(high: 1, low: 2).low,  2 as B.Magnitude)
            Test().same(T(high: 1, low: 2).high, 1 as B)
        }
        
        for base in coreSystemsIntegers {
            whereTheBaseIs(base)
        }
    }
    
    func testBitCast() {
        func whereTheBaseIs<B>(_ type: B.Type) where B: SystemsInteger {
            typealias T = Doublet<B>
            typealias S = Doublet<B>.Signitude
            typealias M = Doublet<B>.Magnitude
            
            Test().same(M(raw: T(low:  1, high:  2)), M(low:  1, high:  2))
            Test().same(S(raw: T(low:  1, high:  2)), S(low:  1, high:  2))
            Test().same(M(raw: T(low: ~1, high: ~2)), M(low: ~1, high: ~2))
            Test().same(S(raw: T(low: ~1, high: ~2)), S(low: ~1, high: ~2))
        }
        
        for base in coreSystemsIntegers {
            whereTheBaseIs(base)
        }
    }
    
    func testMemoryLayout() {
        func whereTheBaseIs<B>(_ type: B.Type) where B: SystemsInteger {
            typealias T = Doublet<B>
            
            Test().same(MemoryLayout<T>.self, MemoryLayout<(B, B)>.self)
            Test().same(MemoryLayout<T>.size, 2 * MemoryLayout<B>.size)
            Test().same(MemoryLayout<T>.size, 2 * MemoryLayout<B>.stride)
            Test().same(MemoryLayout<T>.size, 2 * MemoryLayout<B>.alignment)
        }
        
        for base in coreSystemsIntegers {
            whereTheBaseIs(base)
        }
    }
        
    //*========================================================================*
    // MARK: * Case
    //*========================================================================*
    
    struct Case<Base: SystemsInteger> {
        
        typealias Item = Doublet<Base>
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=

        var test: Test
        var item: Item
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=

        init(_ item: Item, test: Test) {
            self.test = test
            self.item = item
        }
        
        init(_ item: Item, file: StaticString = #file, line: UInt = #line) {
            self.init(item, test: Test(file: file, line: line))
        }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Assertions
//=----------------------------------------------------------------------------=

extension DoubletTests.Case {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    func complement(_ increment: Bool, is expectation: Fallible<Item>) {
        always: do {
            test.same(item.complement(increment), expectation, "complement [0]")
        }
        
        if  increment {
            test.same(item.complement(), expectation.value, "complement [1]")
        }
        
        if  increment, item.high.isNegative {
            test.same(Item(raw: item.magnitude()), expectation.value, "complement [2]")
        }   else {
            test.same(Item(raw: item.magnitude()), item, "complement [3]")
        }
    }
}

