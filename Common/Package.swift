// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"]
        ),
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CommonTesting",
            targets: ["CommonTesting"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Common",
            path: "Sources/Core"
        ),
        .target(
            name: "CommonTesting",
            dependencies: [
                "Common"
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                "Common",
                "CommonTesting"
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "CommonSnapshotsTests",
            dependencies: [
                "Common",
                "CommonTesting"
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
