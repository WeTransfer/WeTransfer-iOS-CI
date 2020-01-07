import Danger
import WeTransferLinter

let danger = Danger()

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
message("These files have changed: \(editedFiles.joined())")

lint(using: danger)
