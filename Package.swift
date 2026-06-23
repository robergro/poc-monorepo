// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECommerceApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ECommerceApp",
            targets: ["ECommerceApp"]
        ),
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ECommerceAppTesting",
            targets: ["ECommerceAppTesting"]
        ),
    ],
    dependencies: [
        .package(path: "./Common"),
        .package(path: "./UserManagementComponent"),
        .package(path: "./ProductCatalogComponent"),
        .package(path: "./OrderManagementComponent"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ECommerceApp",
            dependencies: [
                "Common",
                "UserManagementComponent",
                "ProductCatalogComponent",
                "OrderManagementComponent",
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "ECommerceAppTesting",
            dependencies: [
                "OrderManagementComponent"
            ],
            path: "Sources/Testing"
        ),
        .testTarget(
            name: "ECommerceAppTests",
            dependencies: [
                "ECommerceApp",
                .product(name: "CommonTesting", package: "Common"),
                .product(name: "UserManagementComponentTesting", package: "UserManagementComponent"),
                .product(name: "ProductCatalogComponentTesting", package: "ProductCatalogComponent"),
                .product(name: "OrderManagementComponentTesting", package: "OrderManagementComponent"),
            ],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "ECommerceAppSnapshotsTests",
            dependencies: [
                "ECommerceApp",
                .product(name: "CommonTesting", package: "Common"),
                .product(name: "UserManagementComponentTesting", package: "UserManagementComponent"),
                .product(name: "ProductCatalogComponentTesting", package: "ProductCatalogComponent"),
                .product(name: "OrderManagementComponentTesting", package: "OrderManagementComponent"),
            ],
            path: "Tests/SnapshotTests"
        ),
    ]
)
