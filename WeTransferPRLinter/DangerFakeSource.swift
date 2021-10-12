/// Is used for the Package.swift in implementing projects to have a fake Swift source file.
/// E.g:
/// .target(name: "DangerDependencies", dependencies: ["Danger", "WeTransferPRLinter"], path: "Submodules/WeTransfer-iOS-CI/Danger-Swift", sources: ["DangerFakeSource.swift"]),
