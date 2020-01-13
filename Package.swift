// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Coyote",
    products: [
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]), // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "3.0.0"),
        .package(path: "Danger-Swift")
    ],
    targets: [
        // This is just an arbitrary Swift file in the app, that has
        // no dependencies outside of Foundation, the dependencies section
        // ensures that the library for Danger gets build also.
        .target(name: "DangerDependencies", dependencies: ["Danger", "WeTransferPRLinter"], path: "Danger-Swift", sources: ["DangerFakeSource.swift"]),
    ]
)
