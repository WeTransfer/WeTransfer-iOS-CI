// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeTransferPRLinter",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "WeTransferPRLinter",
            targets: ["WeTransferPRLinter"]
        )
    ],
    dependencies: [
        .package(name: "Danger", url: "https://github.com/danger/swift", from: "3.0.0"),
        .package(name: "DangerSwiftCoverage", url: "https://github.com/f-meloni/danger-swift-coverage", from: "1.1.0"),
        .package(name: "DangerXCodeSummary", url: "https://github.com/f-meloni/danger-swift-xcodesummary", from: "1.2.1"),
        .package(name: "Files", url: "https://github.com/JohnSundell/Files", from: "4.1.1")
    ],
    targets: [
        .target(
            name: "WeTransferPRLinter",
            dependencies: ["Danger", "DangerSwiftCoverage", "DangerXCodeSummary", "Files"]
        ),
        .testTarget(
            name: "WeTransferPRLinterTests",
            dependencies: ["WeTransferPRLinter", .product(name: "DangerFixtures", package: "Danger")]
        )
    ]
)
