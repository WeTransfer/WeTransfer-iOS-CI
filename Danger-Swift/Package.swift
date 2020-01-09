// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeTransferPRLinter",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "WeTransferPRLinter",
            targets: ["WeTransferPRLinter"])
    ],
    dependencies: [
//        .package(url: "https://github.com/danger/swift", from: "2.0.7")
        .package(path: "/Users/antoinevanderlee/Documents/GIT-Projects/Eigen/swift")
    ],
    targets: [
        .target(
            name: "WeTransferPRLinter",
            dependencies: ["Danger"]),
        .testTarget(
            name: "WeTransferPRLinterTests",
            dependencies: ["WeTransferPRLinter", "DangerFixtures"]),
    ]
)
