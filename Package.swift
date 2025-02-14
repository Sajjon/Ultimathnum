// swift-tools-version: 5.9
//=----------------------------------------------------------------------------=
// This source file is part of the Ultimathnum open source project.
//
// Copyright (c)  2023 Oscar Byström Ericsson
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
        .library(
            name: "Ultimathnum",
            targets: ["Ultimathnum"]
        ),
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]
        ),
        .library(
            name: "DoubleIntKit",
            targets: ["DoubleIntKit"]
        ),
        .library(
            name: "FibonacciKit",
            targets: ["FibonacciKit"]
        ),
        .library(
            name: "InfiniIntKit",
            targets: ["InfiniIntKit"]
        ),
    ],
    targets: [
        .target(
            name: "Ultimathnum",
            dependencies: ["CoreKit", "DoubleIntKit", "FibonacciKit", "InfiniIntKit"]
        ),
        .testTarget(
            name: "UltimathnumTests",
            dependencies: ["Ultimathnum", "TestKit"]
        ),
        .target(
            name: "CoreKit",
            dependencies: []
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit", "DoubleIntKit", "InfiniIntKit", "TestKit"]
        ),
        .target(
            name: "DoubleIntKit",
            dependencies: ["CoreKit"]
        ),
        .testTarget(
            name: "DoubleIntKitTests",
            dependencies: ["DoubleIntKit", "TestKit"]
        ),
        .target(
            name: "FibonacciKit",
            dependencies: ["CoreKit"]
        ),
        .testTarget(
            name: "FibonacciKitTests",
            dependencies: ["DoubleIntKit", "FibonacciKit", "InfiniIntKit", "TestKit"]
        ),
        .target(
            name: "InfiniIntKit",
            dependencies: ["CoreKit"]
        ),
        .testTarget(
            name: "InfiniIntKitTests",
            dependencies: ["InfiniIntKit", "TestKit"]
        ),
        .target(
            name: "TestKit",
            dependencies: ["CoreKit"]
        ),
    ]
)
