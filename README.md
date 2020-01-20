# WeTransfer-iOS-CI
![Build Status](https://app.bitrise.io/app/9829cbc3cc6501a3.svg?token=hCyPPIJ1MV2h0xyX1Ux4kA)

Containing shared CI logic to quickly set up your repository with:

- Tests running for each pull request
- Danger reports for each pull request

# Why should I use it?
What's in it for me? Well, quite a lot! With low effort to add it to your project.

- Integrate [SwiftLint](https://github.com/realm/SwiftLint) to lint source code and tests
- Integrate [Fastlane](https://github.com/fastlane/fastlane) to run tests for PRs
- Integrate [Danger](http://danger.systems/) to automatically improve PR reviews

## Danger features
Following is a list of features which are posted in a comment on PRs based on the submitted files.

  - Warn for big PRs, containing more than 500 lines of code
  - Warn for missing PR description
  - Warn for missing updated tests
  - Show code coverage of PR related files
  - Show any failed tests
  - Show all `warnings` and `errors` in the project

All this is written in Swift and fully tested 🚀

### Custom linting
These warnings are posted inline inside the PR, helping you to solve them easily.

  - Check for `final class` usage
  - `override` methods without adding logic
  -  Suggest `weak` over `unowned`
  -  Suggest `// MARK:` usage for large files

![](Assets/danger_comment.png)
_This is an example comment. Note that `WeTransferBot` will be replaced by your own bot. More info can be found here: [Getting started with Danger](http://danger.systems/guides/getting_started.html)._

# Shared Bitrise.yml
The shared Bitrise.yml makes it really easy to integrate CI into open-source projects. It's been optimized using [this](https://blog.bitrise.io/tune-your-bitrise-workflows-using-cache-in-steps) blog post for caching and triggers like:

- Manage gems & brews
- Cache pulling
- Run fastlane for testing
- Run Danger from this repo
- Cache pushing

### How to use this in your Bitrise configuration?
For Danger, you need to set the `DANGER_GITHUB_API_TOKEN` in your Bitrise secrets.

Make sure your Bitrise.yml looks like this:

```yml
trigger_map:
- pull_request_source_branch: "*"
  workflow: open_source_projects
workflows:
  open_source_projects:
    steps:
    - activate-ssh-key@4.0.3:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone@4.0.17: {}
    - script:
        title: Continue from WeTransfer-iOS-CI repo
        inputs:
        - content: |-
            #!/bin/bash
            set -ex
            bitrise run --config ./Bitrise/bitrise.yml "${BITRISE_TRIGGERED_WORKFLOW_ID}"
```

_Note: Don't change `open_source_projects` as this needs to match the Bitrise.yml file workflow._

# How to integrate?

### 1: Add submodule
Add this repository as a submodule with the correct path `Submodules/WeTransfer-iOS-CI`:

```
[submodule "Submodules/WeTransfer-iOS-CI"]
	path = Submodules/WeTransfer-iOS-CI
	url = https://github.com/WeTransfer/WeTransfer-iOS-CI.git
```

### 2: Create a fastlane file

Create a fastlane file which executes testing with code coverage enabled. Import the Fastfile from this repo and trigger the `validate_changes` lane.

```ruby
import "./../Submodules/WeTransfer-iOS-CI/Fastlane/Fastfile"

desc "Run the tests and prepare for Danger"
lane :test do |options|
  test_project(
    project_path: "YOUR_PROJECT_PATH/",
    project_name: "YOUR_PROJECT_NAME", 
    scheme: "YOUR_PROJECT_SCHEME")
end

```

### 3: Integrate SwiftLint in your project
Add a run script and use the common used [SwiftLint](https://github.com/WeTransfer/WeTransfer-iOS-CI/blob/master/SwiftLint/swiftlint.sh) script:

```shell
./Submodules/WeTransfer-iOS-CI/SwiftLint/swiftlint.sh
```

## License

WeTransfer-iOS-CI is available under the MIT license. See the LICENSE file for more info.

