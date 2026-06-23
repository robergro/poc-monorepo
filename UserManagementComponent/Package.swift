// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserManagementComponent",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserManagementComponent",
            targets: ["UserManagementComponent"]
        ),
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UserManagementComponentTesting",
            targets: ["UserManagementComponentTesting"]
        ),
    ],
    dependencies: [
        .package(path: "../Common"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UserManagementComponent",
            dependencies: [
                "Common"
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "UserManagementComponentTesting",
            dependencies: [
                "UserManagementComponent"
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "UserManagementComponentTests",
            dependencies: [
                "UserManagementComponent",
                "UserManagementComponentTesting",
                .product(name: "CommonTesting", package: "Common"),
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "UserManagementSnapshotsTests",
            dependencies: [
                "UserManagementComponent",
                "UserManagementComponentTesting",
                .product(name: "CommonTesting", package: "Common"),
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
