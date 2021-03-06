// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "audio-cli",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .executable(name: "audio-cli", targets: ["audio-cli"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.5.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "audio-cli",
            dependencies: ["ColorizeSwift", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "audio-cliTests",
            dependencies: ["audio-cli"]),
    ]
)
