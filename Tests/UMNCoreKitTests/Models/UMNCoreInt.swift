//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import UMNCoreKit
import XCTest

//*============================================================================*
// MARK: * UMN x Core Int
//*============================================================================*

final class UMNCoreIntTests: XCTestCase {
    
    typealias I = any (UMNSystemInteger &   UMNSignedInteger).Type
    typealias U = any (UMNSystemInteger & UMNUnsignedInteger).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let allIntegers: [any UMNSystemInteger.Type] = allSigned + allUnsigned
    static let allSigned:   [I] = [IX.self, I8.self, I16.self, I32.self, I64.self]
    static let allUnsigned: [U] = [UX.self, U8.self, U16.self, U32.self, U64.self]
}
