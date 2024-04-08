//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import Ultimathnum
import TestKit

//*============================================================================*
// MARK: * Fibonacci x Core Int
//*============================================================================*

extension FibonacciTests {

    //=------------------------------------------------------------------------=
    // MARK: Meta Data
    //=------------------------------------------------------------------------=
    
    private static let coreIntList: [any SystemsInteger.Type] = [
        IX .self,
        I8 .self,
        I16.self,
        I32.self,
        I64.self,
        UX .self,
        U8 .self,
        U16.self,
        U32.self,
        U64.self,
    ]
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testCoreInt() {
        func whereIs<T>(_ type: T.Type) where T: SystemsInteger {
            typealias F = Fibonacci<T>
            
            min: do {
                checkInvariantsAtZero(F.self, test: Test())
            }
            
            brr: do {
                check(try? F(  ), (index: 0, element: 0, next: 1), test: Test())
                check(try? F( 0), (index: 0, element: 0, next: 1), test: Test())
                check(try? F( 1), (index: 1, element: 1, next: 1), test: Test())
                check(try? F( 2), (index: 2, element: 1, next: 2), test: Test())
                check(try? F( 3), (index: 3, element: 2, next: 3), test: Test())
                check(try? F( 4), (index: 4, element: 3, next: 5), test: Test())
                check(try? F( 5), (index: 5, element: 5, next: 8), test: Test())
            }
            
            if  var sequence =  Test().some(try? F(0)) {
                check(sequence, (index: 0, element: 0, next: 1), test: Test())
                Test().success(try sequence.increment())
                check(sequence, (index: 1, element: 1, next: 1), test: Test())
                Test().success(try sequence.increment())
                check(sequence, (index: 2, element: 1, next: 2), test: Test())
                Test().success(try sequence.increment())
                check(sequence, (index: 3, element: 2, next: 3), test: Test())
                Test().success(try sequence.increment())
                check(sequence, (index: 4, element: 3, next: 5), test: Test())
                Test().success(try sequence.increment())
                check(sequence, (index: 5, element: 5, next: 8), test: Test())
            }
            
            if  var sequence =  Test().some(try? F(5)) {
                check(sequence, (index: 5, element: 5, next: 8), test: Test())
                Test().success(try sequence.decrement())
                check(sequence, (index: 4, element: 3, next: 5), test: Test())
                Test().success(try sequence.decrement())
                check(sequence, (index: 3, element: 2, next: 3), test: Test())
                Test().success(try sequence.decrement())
                check(sequence, (index: 2, element: 1, next: 2), test: Test())
                Test().success(try sequence.decrement())
                check(sequence, (index: 1, element: 1, next: 1), test: Test())
                Test().success(try sequence.decrement())
                check(sequence, (index: 0, element: 0, next: 1), test: Test())
            }
        }
        
        for type in Self.coreIntList {
            whereIs(type)
        }
    }
    
    func testCoreIntLimit() {
        if  let sequence = Test().some(try? Fibonacci<I8>(10)) {
            checkInvariantsAtLastElement(sequence, (index: 10, element: 0000000000000000055, next: 00000000000000000089), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<U8>(12)) {
            checkInvariantsAtLastElement(sequence, (index: 12, element: 0000000000000000144, next: 00000000000000000233), test: Test())
        }
                
        if  let sequence = Test().some(try? Fibonacci<I16>(22)) {
            checkInvariantsAtLastElement(sequence, (index: 22, element: 0000000000000017711, next: 00000000000000028657), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<U16>(23)) {
            checkInvariantsAtLastElement(sequence, (index: 23, element: 0000000000000028657, next: 00000000000000046368), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<I32>(45)) {
            checkInvariantsAtLastElement(sequence, (index: 45, element: 0000000001134903170, next: 00000000001836311903), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<U32>(46)) {
            checkInvariantsAtLastElement(sequence, (index: 46, element: 0000000001836311903, next: 00000000002971215073), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<I64>(91)) {
            checkInvariantsAtLastElement(sequence, (index: 91, element: 4660046610375530309, next: 07540113804746346429), test: Test())
        }
        
        if  let sequence = Test().some(try? Fibonacci<U64>(92)) {
            checkInvariantsAtLastElement(sequence, (index: 92, element: 7540113804746346429, next: 12200160415121876738), test: Test())
        }
    }
}
