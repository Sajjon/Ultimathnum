//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Binary Integer x Stride
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public consuming func advanced(by other: Swift.Int) -> Self {
        Self.advanced(self, by: IX(other)).unwrap()
    }
    
    @inlinable public consuming func distance(to other: Self) -> Swift.Int {
        Self.distance(self, to: other, as: IX.self).unwrap().base
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Algorithms
//=----------------------------------------------------------------------------=

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=

    /// ### Development
    ///
    /// - TODO: Rework.
    ///
    @inlinable package static func advanced<T>(_ instance: consuming Self, by distance: T) -> Fallible<Self> where T: SignedInteger {
        if  Self.isSigned {
            
            if  ExchangeInt(Self.bitWidth) >= ExchangeInt(T.bitWidth) {
                
                return instance.plus(Self(truncating: distance))
                
            }   else {
                
                return T(truncating: instance).plus(distance).map(Self.exactly)
                
            }
            
        }   else {
            
            if  distance.isLessThanZero {
                
                return Self.exactly(distance.magnitude).map({ instance.minus($0) })
                
            }   else {
                
                return Self.exactly(distance.magnitude).map({ instance.plus ($0) })
                                
            }
            
        }
    }
    
    /// ### Development
    ///
    /// - TODO: Rework.
    ///
    @inlinable package static func distance<T>(_ instance: Self, to other: Self, as stride: T.Type) -> Fallible<T> where T: SignedInteger {
        if  Self.isSigned {
            
            if  ExchangeInt(Self.bitWidth) <= ExchangeInt(T.bitWidth) {
                
                return T(truncating: other).minus(T(truncating: instance))
                
            }   else {
                
                return other.minus(instance).map(T.exactly)
                
            }
            
        }   else {
            
            if  instance < other {
                
                return T.exactly(other - instance)
                                    
            }   else {
                
                return T.Magnitude.exactly(instance - other).map({ T.exactly(sign: Sign.minus, magnitude: $0) })
                
            }
        }
    }
}
