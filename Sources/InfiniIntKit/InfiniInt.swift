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
// MARK: * Infini Int
//*============================================================================*

/// ### Development
///
/// - TODO: Make it generic over its `Element` type.
///
@frozen public struct InfiniInt<Source>: BinaryInteger where Source: SystemsInteger {
    
    public typealias Element = Source.Element
    
    public typealias IntegerLiteralType = StaticBigInt
    
    public typealias BitPattern = InfiniInt<Source.Magnitude>
    
    public typealias Magnitude  = InfiniInt<Source.Magnitude>
    
    public typealias Signitude  = InfiniInt<Source.Signitude>
    
    @usableFromInline typealias Storage = InfiniIntStorage<Element.Magnitude>
        
    //=------------------------------------------------------------------------=
    // MARK: Metadata
    //=------------------------------------------------------------------------=
    
    @inlinable public static var mode: Source.Mode {
        Source.mode
    }
    
    @inlinable public static var size: Magnitude {
        Magnitude(unchecked: Storage([], repeating: 1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var storage: Storage
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(unchecked storage: consuming Storage) {
        Swift.assert(storage.isNormal, String.brokenInvariant())
        self.storage = storage
    }
    
    @inlinable init(normalizing storage: consuming Storage) {
        storage.normalize()
        self.init(unchecked: storage)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral: RootInt.IntegerLiteralType) {
        self = Self.exactly(RootInt(integerLiteral: integerLiteral)).unwrap()
    }
    
    @inlinable public init(_ body: some Sequence<Element.Magnitude>, repeating appendix: Bit = .zero) {
        self.init(normalizing: Storage(Storage.Body(body), repeating: appendix))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(raw source: consuming BitPattern) {
        self.init(unchecked: source.storage)
    }
    
    @inlinable public consuming func load(as type: BitPattern.Type) -> BitPattern {
        Magnitude(unchecked: self.storage)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Un/signed
//=----------------------------------------------------------------------------=

extension InfiniInt:   SignedInteger where Source:   SignedInteger { }
extension InfiniInt: EdgyInteger where Source: UnsignedInteger { }
extension InfiniInt: UnsignedInteger where Source: UnsignedInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Aliases
//=----------------------------------------------------------------------------=

public typealias IXL = InfiniInt<IX>
public typealias UXL = InfiniInt<UX>
