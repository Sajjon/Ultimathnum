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
// MARK: * Integer Description Format x Encoding
//*============================================================================*

final class IntegerDescriptionFormatTestsOnEncoding: XCTestCase {
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let encoder = Namespace.IntegerDescriptionFormat.Encoder()
    let signs: [(in: Sign?, out: String)] = [(nil, ""), (Sign.plus, "+"), (Sign.minus, "-")]
    let masks: [(in: Bit?,  out: String)] = [(nil, ""), (Bit .zero, "#"), (Bit .one,   "&")]
    
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testEncoding() {
        for count in (0 ..< 4) {
            let x0 = [0] + Array(repeating: 0 as U64, count: count)
            let x1 = [1] + Array(repeating: 0 as U64, count: count)
            
            for sign in signs {
            for mask in masks {
                
                check(Test(), sign.in, mask.in, x0, "\(sign.out)\(mask.out)0")
                check(Test(), sign.in, mask.in, x1, "\(sign.out)\(mask.out)1")
                
            }}
        }
    }
    
    func testInt32() {
        check(Test(), I32(load: 0x00000000 as U32),           "0")
        check(Test(), I32(load: 0x03020100 as U32),    "50462976")
        check(Test(), I32(load: 0x7fffffff as U32),  "2147483647") // I32.max
        check(Test(), I32(load: 0x80000000 as U32), "-2147483648") // I32.min
        check(Test(), I32(load: 0x81807f7e as U32), "-2122285186")
        check(Test(), I32(load: 0xfffefdfc as U32),      "-66052")
        check(Test(), I32(load: 0xffffffff as U32),          "-1")
    }
    
    func testUInt32() {
        check(Test(), U32(load: 0x00000000 as U32),           "0") // U32.min
        check(Test(), U32(load: 0x03020100 as U32),    "50462976")
        check(Test(), U32(load: 0x7fffffff as U32),  "2147483647")
        check(Test(), U32(load: 0x80000000 as U32),  "2147483648")
        check(Test(), U32(load: 0x81807f7e as U32),  "2172682110")
        check(Test(), U32(load: 0xfffefdfc as U32),  "4294901244")
        check(Test(), U32(load: 0xffffffff as U32),  "4294967295") // U32.max
    }

    func testI64() {
        check(Test(), I64(load: 0x0000000000000000 as U64),                    "0")
        check(Test(), I64(load: 0x0706050403020100 as U64),   "506097522914230528")
        check(Test(), I64(load: 0x7fffffffffffffff as U64),  "9223372036854775807") // I64.max
        check(Test(), I64(load: 0x8000000000000000 as U64), "-9223372036854775808") // I64.max
        check(Test(), I64(load: 0x838281807f7e7d7c as U64), "-8970465118873813636")
        check(Test(), I64(load: 0xfffefdfcfbfaf9f8 as U64),     "-283686952306184")
        check(Test(), I64(load: 0xffffffffffffffff as U64),                   "-1")
    }

    func testU64() {
        check(Test(), U64(load: 0x0000000000000000 as U64),                    "0") // U64.min
        check(Test(), U64(load: 0x0706050403020100 as U64),   "506097522914230528")
        check(Test(), U64(load: 0x7fffffffffffffff as U64),  "9223372036854775807")
        check(Test(), U64(load: 0x8000000000000000 as U64),  "9223372036854775808")
        check(Test(), U64(load: 0x838281807f7e7d7c as U64),  "9476278954835737980")
        check(Test(), U64(load: 0xfffefdfcfbfaf9f8 as U64), "18446460386757245432")
        check(Test(), U64(load: 0xffffffffffffffff as U64), "18446744073709551615") // U64.max
    }
    
    // MARK: Tests + Big Integer
    
    func testInt128() {
        for sign in signs {
        for mask in masks {
            
            let x = "\(sign.out)\(mask.out)"
            check(Test(), sign.in, mask.in, [0x0000000000000000, 0x0000000000000000] as [U64],                                       "\(x)0")
            check(Test(), sign.in, mask.in, [0x0706050403020100, 0x0f0e0d0c0b0a0908] as [U64],  "\(x)20011376718272490338853433276725592320")
            check(Test(), sign.in, mask.in, [0xffffffffffffffff, 0x7fffffffffffffff] as [U64], "\(x)170141183460469231731687303715884105727")
            check(Test(), sign.in, mask.in, [0x0000000000000000, 0x8000000000000000] as [U64], "\(x)170141183460469231731687303715884105728")
            check(Test(), sign.in, mask.in, [0x08090a0b0c0d0e10, 0x0001020304050607] as [U64],      "\(x)5233100606242806050955395731361296")
            check(Test(), sign.in, mask.in, [0x0000000000000001, 0x0000000000000000] as [U64],                                       "\(x)1")
            
        }}
    }
    
    func testU128() {
        for sign in signs {
        for mask in masks {
            
            let x = "\(sign.out)\(mask.out)"
            check(Test(), sign.in, mask.in, [0x0000000000000000, 0x0000000000000000] as [U64],                                       "\(x)0")
            check(Test(), sign.in, mask.in, [0x0706050403020100, 0x0f0e0d0c0b0a0908] as [U64],  "\(x)20011376718272490338853433276725592320")
            check(Test(), sign.in, mask.in, [0x0000000000000000, 0x8000000000000000] as [U64], "\(x)170141183460469231731687303715884105728")
            check(Test(), sign.in, mask.in, [0xf7f6f5f4f3f2f1f0, 0xfffefdfcfbfaf9f8] as [U64], "\(x)340277133820332220657323652036036850160")
            check(Test(), sign.in, mask.in, [0xffffffffffffffff, 0x7fffffffffffffff] as [U64], "\(x)170141183460469231731687303715884105727")
            check(Test(), sign.in, mask.in, [0xffffffffffffffff, 0xffffffffffffffff] as [U64], "\(x)340282366920938463463374607431768211455")
            
        }}
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    func check<T>(_ test: Test, _ integer: T, _ expectation: String) where T: BinaryInteger {
        standard: do {
            let result = self.encoder.encode(integer)
            test.same(result, expectation, "integer")
        }
        
        standard: do {
            let sign = Sign(integer.isLessThanZero)
            let magnitude = integer.magnitude()
            let result = self.encoder.encode(sign: sign, magnitude: magnitude)
            test.same(result, expectation, "sign-magnitude")
        }

        standard: do {
            var body = integer            
            let sign: Sign? =  T.isSigned && Bool(body.appendix) ? .minus : nil
            let mask: Bit?  = !T.isSigned && Bool(body.appendix) ? .one   : nil
            
            if  Bool(body.appendix) {
                body = body.complement(T.isSigned).value
            }
            
            self.check(test, sign, mask, body.body(), expectation)
        }
    }
    
    func check<T>(_ test: Test,_ sign: Sign?, _ mask: Bit?, _ body: [T], _ expectation: String) where T: SystemsInteger & UnsignedInteger {
        body.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: U8.self) {
                let result = self.encoder.encode(
                    sign: sign,
                    mask: mask, 
                    body: DataInt.Body($0)!
                )
                
                test.same(result, expectation, "sign-mask-body")
            }
        }
    }
}
