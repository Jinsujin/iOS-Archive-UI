// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AppPackage",
            targets: ["Vanilla"]),
        .library(
            name: "ComposableExample",
            targets: ["ComposableExample"]),

    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.50.0"),
    ],
    targets: [
        .target(
            name: "Vanilla",
            dependencies: []),
        .target(
            name: "ComposableExample",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
        .testTarget(
            name: "ComposableExampleTests",
            dependencies: [
                "ComposableExample",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
    ]
)
