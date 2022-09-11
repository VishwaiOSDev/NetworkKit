// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "NetworkKit", targets: ["NetworkKit"]),
    ],
    dependencies: [
        .package(url: "git@github.com:VishwaiOSDev/LogKit.git", .upToNextMajor(from: "0.0.9"))
    ],
    targets: [
        .target(
            name: "NetworkKit",
            dependencies: [
                .product(name: "LogKit", package: "LogKit")
            ]
        ),
        .testTarget(name: "NetworkKitTests", dependencies: ["NetworkKit"]),
    ]
)
