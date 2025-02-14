//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Triplet
//*============================================================================*

/// An integer split into 3 parts.
@frozen public struct Triplet<Base>: BitCastable, Comparable where Base: SystemsInteger {
    
    public typealias High = Base
    
    public typealias Mid  = Base.Magnitude
    
    public typealias Low  = Base.Magnitude
    
    public typealias BitPattern = Triplet<Base.Magnitude>
        
    public typealias Magnitude  = Triplet<Base.Magnitude>
    
    public typealias Signitude  = Triplet<Base.Signitude>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var high: Base
    public var mid:  Base.Magnitude
    public var low:  Base.Magnitude
    #else
    public var low:  Base.Magnitude
    public var mid:  Base.Magnitude
    public var high: Base
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(low: consuming Base.Magnitude, mid: consuming Base.Magnitude, high: consuming Base) {
        self.low  = low
        self.mid  = mid
        self.high = high
    }
    
    @inlinable public init(high: consuming Base, mid: consuming Base.Magnitude, low: consuming Base.Magnitude) {
        self.high = high
        self.mid  = mid
        self.low  = low
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(low: consuming Base.Magnitude, high: consuming Doublet<Base>) {
        self.low  = low
        self.mid  = high.low
        self.high = high.high
    }
    
    @inlinable public init(high: consuming Doublet<Base>, low: consuming Base.Magnitude) {
        self.high = high.high
        self.mid  = high.low
        self.low  = low
    }
    
    @inlinable public init(high: consuming Base, low: consuming Doublet<Base.Magnitude>) {
        self.high = high
        self.mid  = low.high
        self.low  = low.low
    }
    
    @inlinable public init(low: consuming Doublet<Base.Magnitude>, high: consuming Base) {
        self.low  = low.low
        self.mid  = low.high
        self.high = high
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(raw source: consuming BitPattern) {
        self.init(
            low:  source.low,
            mid:  source.mid,
            high: Base(raw: source.high)
        )
    }
    
    @inlinable public consuming func load(as type: BitPattern.Type) -> BitPattern {
        BitPattern(
            low:  self.low,
            mid:  self.mid,
            high: Base.Magnitude(raw: self.high)
        )
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func ascending() -> (low: Low, mid: Mid, high: High) {
        (low: self.low, mid: self.mid, high: self.high)
    }
    
    @inlinable public consuming func descending() -> (high: High, mid: Mid, low: Low) {
        (high: self.high, mid: self.mid, low: self.low)
    }
}
