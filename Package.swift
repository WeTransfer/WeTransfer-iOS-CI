// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WeTransfer-iOS-CI",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"])
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift", from: "3.12.3"),
        .package(path: "WeTransferPRLinter")
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: [
            .product(name: "Danger", package: "danger-swift"),
            .product(name: "WeTransferPRLinter", package: "WeTransferPRLinter")
        ], path: "DangerFakeSources", sources: ["DangerFakeSource.swift"])
    ]
)
