//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer x Numbers
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init() {
        self = 0
    }
    
    @inlinable public init(_ source: consuming Self) {
        self = source
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public static func exactly(
        sign: consuming Sign = .plus,
        magnitude: consuming Magnitude
    )   -> Fallible<Self> {
        //=--------------------------------------=
        var isLessThanZero = Bool(sign)
        if  isLessThanZero {
            isLessThanZero = magnitude.capture({ $0.negated() })
        }
        //=--------------------------------------=
        let value = Self(bitPattern: magnitude)
        //=--------------------------------------=
        return value.combine(value.isLessThanZero != isLessThanZero)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init<T>(_ source: consuming T) where T: BinaryInteger {
        self = Self.exactly(source).unwrap()
    }
    
    @inlinable public init<T>(truncating source: consuming T) where T: BinaryInteger {
        var stream = ExchangeInt(source, as: Element.Magnitude.self).stream()
        self.init(load: &stream)
    }
    
    @inlinable public static func exactly<T>(
        _ source: consuming T
    )   -> Fallible<Self> where T: BinaryInteger {
        Self.exactly(elements: ExchangeInt(source), isSigned: T.isSigned)
    }
    
    @inlinable public static func exactly<T>(
        elements: consuming ExchangeInt<T, Element>.BitPattern,
        isSigned: consuming Bool
    )   -> Fallible<Self> {
        let appendix = elements.appendix.bit
        var (stream) = elements.stream()
        
        let value = Self.init(load: &stream)
        let success = (value.appendix == appendix)
        && (Self.isSigned == isSigned || appendix == Bit.zero)
        && stream.succinct().count == Int.zero
        
        return value.combine(!success)        
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func complement() -> Self {
        self.complement(true).value
    }
    
    @inlinable public consuming func magnitude() -> Magnitude {
        Magnitude(bitPattern: self.isLessThanZero ? self.complement() : self)
    }
}
