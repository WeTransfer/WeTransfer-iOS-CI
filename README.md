# WeTransfer-iOS-CI
![Build Status](https://app.bitrise.io/app/7d0461fc8e66fea4.svg?token=lg7wtKj13ZJhCrdMttXjhA)

Containing shared CI logic to quickly set up your repository with:

- Tests running for each pull request
- Danger reports for each pull request

# Why should I use it?
What's in it for me? Well, quite a lot! With low effort to add it to your project.

- Integrate [SwiftLint](https://github.com/realm/SwiftLint) to lint source code and tests.
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

All this is writting in Swift 🚀

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

desc "Clean the derived data, run tests validate the changes"
lane :test do |options|
  # clear_derived_data

  # Set timeout to prevent xcodebuild -list -project to take to much retries.
  ENV["FASTLANE_XCODE_LIST_TIMEOUT"] = "120"

  begin
    scan(
      scheme: options[:scheme],
      project: "#{options[:project_name]}.xcodeproj",
      device: "iPhone 7",
      clean: true,
      code_coverage: true,
      formatter: "xcpretty-json-formatter"
    )
  rescue => ex
    UI.error("Tests failed: #{ex}")
  end

  validate_changes(project_name: options[:project_name])
end
```

### 3: Integrate SwiftLint in your project
Add a run script and use the following script:

```shell
if [ -z "$CI" ]; then
    if which swiftlint >/dev/null; then
        swiftlint --config "${SRCROOT}/Submodules/WeTransfer-iOS-CI/SwiftLint/.swiftlint-source.yml"
        swiftlint --config "${SRCROOT}/Submodules/WeTransfer-iOS-CI/SwiftLint/.swiftlint-tests.yml"
    else
        echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    fi
fi
```

![](Assets/runscript.png)

### 4: Run fastlane
You can now run fastlane using your CI environment. This can be integrated easily using the script in this repo inside your CI script:

```
- "./Submodules/WeTransfer-iOS-CI/Scripts/travis.sh PROJECT_NAME"
```

_Note: replace **PROJECT\_NAME** with your project name_

An example of a `travis.yml`:

```
language: objective-c
osx_image: xcode9.2
gemfile: Gemfile
bundler_args: "--without documentation --path bundle" # Don't download documentation for gems.
cache:
  bundler: true
  directories:
    - /tmp/SwiftLint # Cache SwiftLint (absolute url on purpose)
env:
  global:
    - NOKOGIRI_USE_SYSTEM_LIBRARIES=true # Prevents long install time http://awesomism.co.uk/nokogiri-slow-install/

script:
  - "./Submodules/WeTransfer-iOS-CI/Scripts/travis.sh WeScan" # Run WeTransfer iOS CI Travis script
```

## License

WeTransfer-iOS-CI is available under the MIT license. See the LICENSE file for more info.

