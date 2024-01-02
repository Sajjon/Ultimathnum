//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import Ultimathnum
import XCTest

//*============================================================================*
// MARK: * UMN x Core Int x Logic
//*============================================================================*

extension UMNCoreIntTests {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testLogicalNot() {
        func whereIs<T>(_ type: T.Type) where T: UMNSystemInteger {
            XCTAssertEqual(~T.min, T.max as T)
            XCTAssertEqual(~T.max, T.min as T)
        }
        
        for type in Self.allIntegers {
            whereIs(type)
        }
    }
    
    func testLogicalAnd() {
        func whereIs<T>(_ type: T.Type) where T: UMNSystemInteger {
            XCTAssertEqual(~1 & ~1, ~1 as T)
            XCTAssertEqual(~1 & ~0, ~1 as T)
            XCTAssertEqual(~1 &  0,  0 as T)
            XCTAssertEqual(~1 &  1,  0 as T)
            
            XCTAssertEqual(~0 & ~1, ~1 as T)
            XCTAssertEqual(~0 & ~0, ~0 as T)
            XCTAssertEqual(~0 &  0,  0 as T)
            XCTAssertEqual(~0 &  1,  1 as T)
            
            XCTAssertEqual( 0 & ~1,  0 as T)
            XCTAssertEqual( 0 & ~0,  0 as T)
            XCTAssertEqual( 0 &  0,  0 as T)
            XCTAssertEqual( 0 &  1,  0 as T)
            
            XCTAssertEqual( 1 & ~1,  0 as T)
            XCTAssertEqual( 1 & ~0,  1 as T)
            XCTAssertEqual( 1 &  0,  0 as T)
            XCTAssertEqual( 1 &  1,  1 as T)
        }
        
        for type in Self.allIntegers {
            whereIs(type)
        }
    }
    
    func testLogicalOr() {
        func whereIs<T>(_ type: T.Type) where T: UMNSystemInteger {
            XCTAssertEqual(~1 | ~1, ~1 as T)
            XCTAssertEqual(~1 | ~0, ~0 as T)
            XCTAssertEqual(~1 |  0, ~1 as T)
            XCTAssertEqual(~1 |  1, ~0 as T)
            
            XCTAssertEqual(~0 | ~1, ~0 as T)
            XCTAssertEqual(~0 | ~0, ~0 as T)
            XCTAssertEqual(~0 |  0, ~0 as T)
            XCTAssertEqual(~0 |  1, ~0 as T)
            
            XCTAssertEqual( 0 | ~1, ~1 as T)
            XCTAssertEqual( 0 | ~0, ~0 as T)
            XCTAssertEqual( 0 |  0,  0 as T)
            XCTAssertEqual( 0 |  1,  1 as T)
            
            XCTAssertEqual( 1 | ~1, ~0 as T)
            XCTAssertEqual( 1 | ~0, ~0 as T)
            XCTAssertEqual( 1 |  0,  1 as T)
            XCTAssertEqual( 1 |  1,  1 as T)
        }
        
        for type in Self.allIntegers {
            whereIs(type)
        }
    }
    
    func testLogicalXor() {
        func whereIs<T>(_ type: T.Type) where T: UMNSystemInteger {
            XCTAssertEqual(~1 ^ ~1,  0 as T)
            XCTAssertEqual(~1 ^ ~0,  1 as T)
            XCTAssertEqual(~1 ^  0, ~1 as T)
            XCTAssertEqual(~1 ^  1, ~0 as T)
            
            XCTAssertEqual(~0 ^ ~1,  1 as T)
            XCTAssertEqual(~0 ^ ~0,  0 as T)
            XCTAssertEqual(~0 ^  0, ~0 as T)
            XCTAssertEqual(~0 ^  1, ~1 as T)
            
            XCTAssertEqual( 0 ^ ~1, ~1 as T)
            XCTAssertEqual( 0 ^ ~0, ~0 as T)
            XCTAssertEqual( 0 ^  0,  0 as T)
            XCTAssertEqual( 0 ^  1,  1 as T)
            
            XCTAssertEqual( 1 ^ ~1, ~0 as T)
            XCTAssertEqual( 1 ^ ~0, ~1 as T)
            XCTAssertEqual( 1 ^  0,  1 as T)
            XCTAssertEqual( 1 ^  1,  0 as T)
        }
        
        for type in Self.allIntegers {
            whereIs(type)
        }
    }
}
