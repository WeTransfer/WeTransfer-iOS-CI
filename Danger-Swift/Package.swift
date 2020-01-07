// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Tester",
    products: [
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]), // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift", from: "2.0.7"),
        .package(path: "Plugins/WeTransferLinterPlugin"),
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: ["Danger", "WeTransferLinter"]), // dev
    ]
)
