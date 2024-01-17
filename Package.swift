// swift-tools-version: 5.9
//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c) 2023 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import PackageDescription

//*============================================================================*
// MARK: * Ultimathnum
//*============================================================================*

let package = Package(
    name: "Ultimathnum",
    platforms: [
        .iOS(.v17),
        .macCatalyst(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        //=--------------------------------------=
        // Ultimathnum
        //=--------------------------------------=
        .library(
        name: "Ultimathnum",
        targets: ["Ultimathnum"]),
        //=--------------------------------------=
        // Big Int Kit
        //=--------------------------------------=
        .library(
        name: "BigIntKit",
        targets: ["BigIntKit"]),
        //=--------------------------------------=
        // Bit Int Kit
        //=--------------------------------------=
        .library(
        name: "BitIntKit",
        targets: ["BitIntKit"]),
        //=--------------------------------------=
        // Core Kit
        //=--------------------------------------=
        .library(
        name: "CoreKit",
        targets: ["CoreKit"]),
        //=--------------------------------------=
        // Double Int Kit
        //=--------------------------------------=
        .library(
        name: "DoubleIntKit",
        targets: ["DoubleIntKit"]),
        //=--------------------------------------=
        // Normal Int Kit
        //=--------------------------------------=
        .library(
        name: "NormalIntKit",
        targets: ["NormalIntKit"]),
        //=--------------------------------------=
        // Signed Int Kit
        //=--------------------------------------=
        .library(
        name: "SignedIntKit",
        targets: ["SignedIntKit"]),
    ],
    targets: [
        //=--------------------------------------=
        // Ultimathnum
        //=--------------------------------------=
        .target(
        name: "Ultimathnum",
        dependencies: [
            "CoreKit",
            "BigIntKit",
            "BitIntKit",
            "DoubleIntKit",
            "NormalIntKit",
            "SignedIntKit",
        ]),
        
        .testTarget(
        name: "UltimathnumTests",
        dependencies: ["Ultimathnum", "TestKit"]),
        //=--------------------------------------=
        // Big Int Kit
        //=--------------------------------------=
        .target(
        name: "BigIntKit",
        dependencies: ["CoreKit"]),
        
        .testTarget(
        name: "BigIntKitTests",
        dependencies: ["BigIntKit", "TestKit"]),
        //=--------------------------------------=
        // Bit Int Kit
        //=--------------------------------------=
        .target(
        name: "BitIntKit",
        dependencies: ["CoreKit"]),
        
        .testTarget(
        name: "BitIntKitTests",
        dependencies: ["BitIntKit", "TestKit"]),
        //=--------------------------------------=
        // Core Kit
        //=--------------------------------------=
        .target(
        name: "CoreKit",
        dependencies: []),
        
        .testTarget(
        name: "CoreKitTests",
        dependencies: [
            "CoreKit",
            "BigIntKit",
            "BitIntKit",
            "DoubleIntKit",
            "NormalIntKit",
            "SignedIntKit",
            "TestKit",
        ]),
        //=--------------------------------------=
        // Double Int Kit
        //=--------------------------------------=
        .target(
        name: "DoubleIntKit",
        dependencies: ["CoreKit"]),
        
        .testTarget(
        name: "DoubleIntKitTests",
        dependencies: ["DoubleIntKit", "TestKit"]),
        //=--------------------------------------=
        // Normal Int Kit
        //=--------------------------------------=
        .target(
        name: "NormalIntKit",
        dependencies: ["CoreKit"]),
        
        .testTarget(
        name: "NormalIntKitTests",
        dependencies: ["NormalIntKit", "TestKit"]),
        //=--------------------------------------=
        // Signed Int Kit
        //=--------------------------------------=
        .target(
        name: "SignedIntKit",
        dependencies: ["CoreKit"]),
        
        .testTarget(
        name: "SignedIntKitTests",
        dependencies: ["SignedIntKit", "TestKit"]),
        //=--------------------------------------=
        // Test Kit
        //=--------------------------------------=
        .target(
        name: "TestKit",
        dependencies: ["CoreKit"]),
    ]
)
