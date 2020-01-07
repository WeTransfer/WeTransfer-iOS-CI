// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeTransferLinter",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "WeTransferLinter",
            targets: ["WeTransferLinter"])
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "2.0.7")
    ],
    targets: [
        .target(
            name: "WeTransferLinter",
            dependencies: ["Danger"]),
        .testTarget(
            name: "WeTransferLinterTests",
            dependencies: ["WeTransferLinter"]),
    ]
)
