// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeTransferPRLinter",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WeTransferPRLinter",
            targets: ["WeTransferPRLinter"]
        )
    ],
    dependencies: [
        // Local package is required for development since Danger does not support Swift 5.5 correctly yet with Danger-Plugin testing.
//         .package(name: "danger-swift", path: "../../../../../Forks/swift"),
               .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "3.12.1"),
//        .package(name: "danger-swift", url: "https://github.com/AvdLee/swift.git", .branch("master")),
               .package(name: "Files", url: "https://github.com/JohnSundell/Files", from: "4.1.1"),
               .package(name: "XCResultKit", url: "https://github.com/davidahouse/XCResultKit.git", from: "0.9.2")
    ],
    targets: [
        .target(
            name: "WeTransferPRLinter",
            dependencies: [
                .product(name: "Danger", package: "danger-swift"),
                "Files",
                "XCResultKit"
            ]
        ),
        .testTarget(
            name: "WeTransferPRLinterTests",
            dependencies: [
                "WeTransferPRLinter",
                .product(name: "DangerFixtures", package: "danger-swift")
            ],
            resources: [
                .copy("Resources/")
            ]
        )
    ]
)
