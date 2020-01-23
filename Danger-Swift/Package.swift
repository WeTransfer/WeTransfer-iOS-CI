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
        .package(url: "https://github.com/danger/swift", from: "3.0.0"),
        .package(url: "https://github.com/f-meloni/danger-swift-coverage", from: "1.1.0"),
        //.package(url: "https://github.com/f-meloni/danger-swift-xcodesummary", from: "1.2.0"),
        .package(url: "https://github.com/AvdLee/danger-swift-xcodesummary.git", .branch("feature/duplicate-filtering")),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.1.1")
    ],
    targets: [
        .target(
            name: "WeTransferPRLinter",
            dependencies: ["Danger", "DangerSwiftCoverage", "DangerXCodeSummary", "Files"]),
        .testTarget(
            name: "WeTransferPRLinterTests",
            dependencies: ["WeTransferPRLinter", "DangerFixtures"])
    ]
)
