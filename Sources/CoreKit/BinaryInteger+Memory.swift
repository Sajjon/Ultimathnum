//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer x Memory
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public static func exactly(
        _ source: DataInt<Element.Magnitude>, mode: some Signedness
    )   -> Fallible<Self> {
        //=--------------------------------------=
        let instance = Self(load: source)
        var success  = Bit(instance.appendix == source.appendix)
        //=--------------------------------------=
        if  Self.isSigned != mode.isSigned {
            success &= (((~source.appendix)))
        }
        
        if  let size  = UX(size: Self.self) {
            let ratio = size / UX(size: Element.Magnitude.self)
            success  &= Bit(source[ratio...].normalized().body.count == .zero)
        }
        //=--------------------------------------=
        return instance.combine(!Bool(success))
    }
    
    @inlinable public static func exactly(
        _ source: DataInt<U8.Magnitude>, mode: some Signedness
    )   -> Fallible<Self> {
        //=--------------------------------------=
        let instance = Self(load: source)
        var success  = Bit(instance.appendix == source.appendix)
        //=--------------------------------------=
        if  Self.isSigned != mode.isSigned {
            success &= (((~source.appendix)))
        }
        
        if  let size  = UX(size: Self.self) {
            let ratio = size / UX(size: U8.Magnitude.self)
            success  &= Bit(source[ratio...].normalized().body.count == .zero)
        }
        //=--------------------------------------=
        return instance.combine(!Bool(success))
    }
    
    @inlinable public static func exactly<OtherElement>(
        _ source: DataInt<OtherElement>, mode: some Signedness
    )   -> Fallible<Self> {
                
        if  OtherElement.elementsCanBeRebound(to: Self.Element.Magnitude.self) {
            return (source).withMemoryRebound(to: Self.Element.Magnitude.self) {
                return Self.exactly($0, mode: mode)
            }
            
        }   else {
            return (source).withMemoryRebound(to: U8.Magnitude.self) {
                return Self.exactly($0, mode: mode)
            }
        }
    }
    
    @inlinable public init<OtherElement>(load source: DataInt<OtherElement>) {
        if  OtherElement.elementsCanBeRebound(to: Self.Element.Magnitude.self) {
            self = (source).withMemoryRebound(to: Self.Element.Magnitude.self, perform: Self.init(load:))
        }   else {
            self = (source).withMemoryRebound(to: U8.self, perform: Self.init(load:))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init<T>(load source: consuming T) where T: SystemsInteger<UX.BitPattern> {
        if  T.isSigned {
            self.init(load: UX.Signitude(bitPattern: source))
        }   else {
            self.init(load: UX.Magnitude(bitPattern: source))
        }
    }
    
    @inlinable public borrowing func load<T>(as type: T.Type) -> T where T: SystemsInteger<UX.BitPattern> {
        T(bitPattern: self.load(as: UX.BitPattern.self))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init<T>(load source: consuming T) where T: SystemsInteger<Element.BitPattern> {
        if  T.isSigned {
            self.init(load: Element.Signitude(bitPattern: source))
        }   else {
            self.init(load: Element.Magnitude(bitPattern: source))
        }
    }
    
    @inlinable public borrowing func load<T>(as type: T.Type) -> T where T: SystemsInteger<Element.BitPattern> {
        T(bitPattern: self.load(as: Element.BitPattern.self))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializeres
    //=------------------------------------------------------------------------=
    
    /// ### Development
    ///
    /// - TODO: Consider BinaryInteger.Largest asseociated type fast path.
    ///
    @inlinable public init<Other>(load source: consuming Other) where Other: BinaryInteger {
        let lhsIsSmall = UX(size: Self .self).map({ $0 <= UX.size }) == true
        let rhsIsSmall = UX(size: Other.self).map({ $0 <= UX.size }) == true
        
        if  lhsIsSmall || rhsIsSmall {
            if  Other.isSigned  {
                self.init(load: IX(load: source))
            }   else {
                self.init(load: UX(load: source))
            }

        }   else {
            self = source.withUnsafeBinaryIntegerElements(perform: Self.init(load:))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func withUnsafeBinaryIntegerElements<Value>(
        perform action: (DataInt<Element.Magnitude>) throws -> Value
    )   rethrows -> Value {
        //=--------------------------------------=
        let appendix: Bit = self.appendix
        //=--------------------------------------=
        return try self.withUnsafeBinaryIntegerBody {
            try action(DataInt($0, repeating: appendix))
        }
    }  
    
    @inlinable public mutating func withUnsafeMutableBinaryIntegerElements<Value>(
        perform action: (MutableDataInt<Element.Magnitude>) throws -> Value
    )   rethrows -> Value {
        //=--------------------------------------=
        let appendix: Bit = self.appendix
        //=--------------------------------------=
        return try self.withUnsafeMutableBinaryIntegerBody {
            try action(MutableDataInt($0, repeating: appendix))
        }
    }
    
    @inlinable public func withUnsafeBinaryIntegerElements<OtherElement, Value>(
        as type: OtherElement.Type,
        perform action: (DataInt<OtherElement>) throws -> Value
    )   rethrows -> Optional<Value> {
        
        if  Self.elementsCanBeRebound(to: OtherElement.self) {
            return try self.withUnsafeBinaryIntegerElements {
                try $0.withMemoryRebound(to: OtherElement.self, perform: action)
            }
            
        }   else {
            return nil
        }
    }

    @inlinable public mutating func withUnsafeMutableBinaryIntegerElements<OtherElement, Value>(
        as type: OtherElement.Type,
        perform action: (MutableDataInt<OtherElement>) throws -> Value
    )   rethrows -> Optional<Value> {
        
        if  Self.elementsCanBeRebound(to: OtherElement.self) {
            return try self.withUnsafeMutableBinaryIntegerElements {
                try $0.withMemoryRebound(to: OtherElement.self, perform: action)
            }
            
        }   else {
            return nil
        }
    }
    
    @inlinable public func withUnsafeBinaryIntegerElementsAsBytes<Value>(
        perform action: (DataInt<U8.Magnitude>) throws -> Value
    )   rethrows -> Value {
        
        try self.withUnsafeBinaryIntegerElements(as: U8.self, perform: action)!
    }
    
    @inlinable public mutating func withUnsafeMutableBinaryIntegerElementsAsBytes<Value>(
        perform action: (MutableDataInt<U8.Magnitude>) throws -> Value
    )   rethrows -> Value {
        
        try self.withUnsafeMutableBinaryIntegerElements(as: U8.self, perform: action)!
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// ### Development
    ///
    /// This is an Unsafe Pyramid of Doom convenience method.
    ///
    /// ``` swift
    /// IX(123).elements.body()       // when view types exist
    /// IX(123).elements.prefix(1234) // when view types exist
    /// IX(123).elements.normalized() // when view types exist
    /// ```
    ///
    @inlinable public func body() -> [Element.Magnitude] {
        self.body(as: [Element.Magnitude].self)
    }
    
    /// ### Development
    ///
    /// This is an Unsafe Pyramid of Doom convenience method.
    ///
    /// ``` swift
    /// IX(123).elements.body()       // when view types exist
    /// IX(123).elements.prefix(1234) // when view types exist
    /// IX(123).elements.normalized() // when view types exist
    /// ```
    ///
    @inlinable public func body<T>(as type: T.Type = T.self) -> T where
    T: RangeReplaceableCollection, T.Element: SystemsInteger & UnsignedInteger {
        self.withUnsafeBinaryIntegerElementsAsBytes {
            T(LoadInt($0).body())
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func elementsCanBeRebound<OtherElement>(to type: OtherElement.Type) -> Bool where OtherElement: SystemsInteger {
        let size      = Int.zero == MemoryLayout<Self.Element>.size      % MemoryLayout<OtherElement>.size
        let stride    = Int.zero == MemoryLayout<Self.Element>.stride    % MemoryLayout<OtherElement>.stride
        let alignment = Int.zero == MemoryLayout<Self.Element>.alignment % MemoryLayout<OtherElement>.alignment
        return Bool(Bit(size) & Bit(stride) & Bit(alignment))
    }
}
