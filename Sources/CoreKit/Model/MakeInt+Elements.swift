//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Make Int
//*============================================================================*

extension MakeInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// The word at `index`, ordered from least significant to most significant.
    @inlinable public subscript(index: UX) -> UX {
        if  let index = IX.exactly(index).optional() {
            return UX(raw: self.base[Int(index)])
        }   else {
            return UX.init(repeating: self.appendix)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func withUnsafeBinaryIntegerElements<T>(_ action: (DataInt<UX>) throws -> T) rethrows -> T {
        try self.withUnsafeBinaryIntegerBody {
            try action(DataInt($0, repeating: self.appendix))
        }
    }
    
    @inlinable public func withUnsafeBinaryIntegerBody<T>(_ action: (DataInt<UX>.Body) throws -> T) rethrows -> T {
        let count = IX(self.size.division(Divisor(UX.size)!).ceil().assert())
        return try Swift.withUnsafeTemporaryAllocation(of: UX.self, capacity: Int(count)) { buffer in
            //=--------------------------------------=
            // pointee: initialization
            //=--------------------------------------=
            for index in IX.zero ..< count {
                buffer.initializeElement(at: Int(index), to: self[UX(raw: index)])
            }
            //=--------------------------------------=
            // pointee: deferred deinitialization
            //=--------------------------------------=
            defer {
                buffer[..<Int(count)].deinitialize()
            }
            //=--------------------------------------=
            return try action(DataInt.Body(UnsafeBufferPointer(buffer))!)
        }
    }
}
