//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Double Int Layout
//*============================================================================*

/// An integer split into 2 parts.
@frozen public struct DoubleIntLayout<Base>: Comparable, Hashable where Base: SystemsInteger {
    
    public typealias Magnitude = DoubleIntLayout<Base.Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var high: Base
    public var low:  Base.Magnitude
    #else
    public var low:  Base.Magnitude
    public var high: Base
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(low: Base.Magnitude, high: Base) {
        self.low  = low
        self.high = high
    }
    
    @inlinable public init(high: Base, low: Base.Magnitude) {
        self.high = high
        self.low  = low
    }
    
    @inlinable public init(ascending  components: (low: Base.Magnitude, high: Base)) {
        self.init(low: components.low, high: components.high)
    }
    
    @inlinable public init(descending components: (high: Base, low: Base.Magnitude)) {
        self.init(high: components.high, low: components.low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var ascending:  (low: Base.Magnitude, high: Base) {
        consuming get {
            (low: self.low, high: self.high)
        }
        
        consuming set {
            (low: self.low, high: self.high) = newValue
        }
    }
    
    @inlinable public var descending: (high: Base, low: Base.Magnitude) {
        consuming get {
            (high: self.high, low: self.low)
        }
        
        consuming set {
            (high: self.high, low: self.low) = newValue
        }
    }
}
