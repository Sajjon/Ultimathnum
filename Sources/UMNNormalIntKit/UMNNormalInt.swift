//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import UMNCoreKit

//*============================================================================*
// MARK: * UMN x Normal Int
//*============================================================================*

@frozen public struct UMNNormalInt: UMNUnsigned & UMNBinaryInteger {
    
    @usableFromInline typealias Element = UX
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var storage: Storage
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(storage: Storage) {
        self.storage = storage
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var magnitude: Self {
        consuming get { self }
    }
    
    @inlinable public var standard: some Swift.BinaryInteger {
        consuming get { UMNStandardInt(self) }
    }
    
    @inlinable public consuming func withUnsafeBufferPointer<T>(_ body: (UnsafeBufferPointer<UX>) -> T) -> T {
        switch self.storage {
        case let .some(x): x.withUnsafeBufferPointer(body)
        case let .many(x): x.withUnsafeBufferPointer(body) }
    }
    
    //*========================================================================*
    // MARK: * Storage
    //*========================================================================*
    
    @frozen @usableFromInline enum Storage: Hashable, Sendable {
        case some(Element) // one
        case many(ContiguousArray<Element>) // at least one
    }
}
