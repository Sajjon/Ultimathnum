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
// MARK: * Ultimathnum x Core Int
//*============================================================================*

extension UltimathnumTests {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    #warning("reduce the get count")
    func testCoreIntToFromExactly() {
        func whereIs<T, U>(_ type: T.Type, _ other: U.Type) where T: SystemsInteger, U: BinaryInteger {
            if  let i = try? U.exactly(T.min).get().plus(U.exactly(T.min).get()).get().minus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.min).get().plus(U.exactly(T.min).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.isSigned ? nil as T? : 0 as T?)
            }
            
            if  let i = try? U.exactly(T.min).get().plus(U.exactly(T.min).get()).get().plus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.isSigned ? nil as T? : 1 as T?)
            }
            
            if  let i = try? U.exactly(T.min).get().minus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.min).get().minus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.min).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.min)
            }
            
            if  let i = try? U.exactly(T.min).get().plus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.min + 1)
            }
            
            if  let i = try? U.exactly(T.max).get().minus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.max - 1)
            }
            
            if  let i = try? U.exactly(T.max).get() {
                XCTAssertEqual(try? T.exactly(i).get(), T.max)
            }
            
            if  let i = try? U.exactly(T.max).get().plus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.max).get().plus(U.exactly(T.max).get()).get().minus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.max).get().plus(U.exactly(T.max).get()).get(){
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
            
            if  let i = try? U.exactly(T.max).get().plus(U.exactly(T.max).get()).get().plus(U.exactly(magnitude: 1).get()).get() {
                XCTAssertEqual(try? T.exactly(i).get(), nil as T?)
            }
        }
        
        for type in Self.coreIntList {
            for other in Self.types {
                whereIs(type, other)
            }
        }
    }
}
