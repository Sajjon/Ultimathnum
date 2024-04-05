//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Division x Bit
//*============================================================================*

extension Division: BitCastable where Quotient: BitCastable, Remainder: BitCastable {
    
    public typealias BitPattern = BitCastItem<(quotient: Quotient.BitPattern, remainder: Remainder.BitPattern)>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @inlinable public init(bitPattern: consuming BitPattern) {
        self.init(
            quotient:  Quotient (bitPattern: bitPattern.storage.quotient ),
            remainder: Remainder(bitPattern: bitPattern.storage.remainder)
        )
    }
    
    @inlinable public var bitPattern: BitPattern {
        consuming get {
            BitPattern((
                quotient:  Quotient .BitPattern(bitPattern: self.quotient ),
                remainder: Remainder.BitPattern(bitPattern: self.remainder)
            ))
        }
    }
}
