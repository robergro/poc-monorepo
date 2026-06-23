// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrderManagementComponent",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OrderManagementComponent",
            targets: ["OrderManagementComponent"]
        ),
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OrderManagementComponentTesting",
            targets: ["OrderManagementComponentTesting"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OrderManagementComponent",
            dependencies: [
                "Common"
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "OrderManagementComponentTesting",
            dependencies: [
                "OrderManagementComponent"
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "OrderManagementComponentTests",
            dependencies: [
                "OrderManagementComponent",
                "OrderManagementComponentTesting",
                .product(name: "CommonTesting", package: "Common"),
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "OrderManagementSnapshotsTests",
            dependencies: [
                "OrderManagementComponent",
                "OrderManagementComponentTesting",
                .product(name: "CommonTesting", package: "Common"),
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
