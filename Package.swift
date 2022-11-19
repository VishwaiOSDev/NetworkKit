// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "NetworkKit", targets: ["NetworkKit"]),
    ],
    dependencies: [
        .package(url: "git@github.com:VishwaiOSDev/LogKit.git", .upToNextMajor(from: "0.0.9")),
        
        // Plugin
        .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "NetworkKit",
            dependencies: [
                .product(name: "LogKit", package: "LogKit")
            ],
            plugins: [
                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
            ]
        ),
        .testTarget(name: "NetworkKitTests", dependencies: ["NetworkKit"]),
    ]
)
