// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WeTransfer-iOS-CI",
    products: [
        .library(name: "DangerDeps[CI]", type: .dynamic, targets: ["DangerDependencies"]) // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "3.0.0"),
        .package(path: "WeTransferPRLinter")
    ],
    targets: [
        // This is just an arbitrary Swift file in the app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(
            name: "DangerDependencies",
            dependencies: [
                .product(name: "Danger", package: "swift"),
                "WeTransferPRLinter"
            ],
            path: "WeTransferPRLinter",
            sources: ["DangerFakeSource.swift"]
        )
    ]
)
