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
- Easily add automated releases based on tag-triggers

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

# How to integrate?

### 1: Add submodule
Add this repository as a submodule with the correct path `Submodules/WeTransfer-iOS-CI`:

```
[submodule "Submodules/WeTransfer-iOS-CI"]
	path = Submodules/WeTransfer-iOS-CI
	url = https://github.com/WeTransfer/WeTransfer-iOS-CI.git
```

### 2: Create a fastlane file

Create a fastlane file which executes testing with code coverage enabled. Import the Fastfile from this repo and trigger the `test` lane.

```ruby
import "./../Submodules/WeTransfer-iOS-CI/Fastlane/Fastfile"
import "./../Submodules/WeTransfer-iOS-CI/Fastlane/shared_lanes.rb"

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

### 4: Make use of the shared Bitrise.yml workflows
The shared Bitrise.yml files make it really easy to integrate CI into open-source projects. It's been optimized using [this](https://blog.bitrise.io/tune-your-bitrise-workflows-using-cache-in-steps) blog post for caching and triggers like:

- Manage gems & brews
- Cache pulling
- Run fastlane for testing
- Run Danger from this repo
- Cache pushing

#### How to use this in your Bitrise configuration?
For Danger, you need to set the `DANGER_GITHUB_API_TOKEN` in your Bitrise secrets.

Make sure your Bitrise.yml looks like this:

```yml
trigger_map:
- pull_request_source_branch: "*"
  workflow: wetransfer_pr_testing
workflows:
  wetransfer_pr_testing:
    steps:
    - activate-ssh-key:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone: {}
    - script:
        title: Continue from WeTransfer-iOS-CI repo
        inputs:
        - content: |-
            #!/bin/bash
            set -ex
            bitrise run --config ./Bitrise/testing_bitrise.yml "${BITRISE_TRIGGERED_WORKFLOW_ID}"
```

_Note: Don't change `wetransfer_pr_testing` as this needs to match the Bitrise.yml file workflow._

### 5: Add automated releases based on tags
By making use of the Bitrise tag triggered builds we can automate the releases of open-source projects. The automation currently performs the following steps:

- Automatically fetch the changelog using the [ChangelogProducer](https://github.com/WeTransfer/ChangelogProducer)
- Create a GitHub release containing the changelog
- Update and push the podspec
- Update the `Changelog.md` with the new changes
- Create a release branch and open a PR for those changes

#### How to use this in your Bitrise configuration?
As open-source projects are making use of HTTPS by default we need to force Bitrise to use SSH instead. Therefore, we need to add the SSH key manually to the secret environment variables with the key `SSH_RSA_PRIVATE_KEY`. You can can read more about this here: [How can I generate an SSH key pair?](https://devcenter.bitrise.io/faq/how-to-generate-ssh-keypair/).

We also need to create a environment secret for CocoaPods trunk pushes with the key `COCOAPODS_TRUNK_TOKEN`. How to do that is explained here: [Automated CocoaPod releases with CI](https://fuller.li/posts/automated-cocoapods-releases-with-ci/).

After all, you're secrets should look as follows:

![](Assets/bitrise_env_vars.png)

After that, we need to add a new trigger for tags:

```yaml
trigger_map:
- pull_request_source_branch: "*"
  workflow: wetransfer_pr_testing
- tag: "*"
  workflow: wetransfer_tag_releasing
```

And we need to add the new workflow:

```yaml
wetransfer_tag_releasing:
steps:
- activate-ssh-key:
    run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
- script:
    title: Force SSH
    inputs:
    - content: |-
        #!/usr/bin/env bash
        # As we work with submodules, make sure we use SSH for this config so we can push our PR later on.
        # See for more info: https://discuss.bitrise.io/t/git-force-to-use-ssh-url-instead-of-https-for-github-com/4384
        git config --global url."git@github.com:".insteadOf "https://github.com/"
- git-clone: {}
- script:
    title: Continue from WeTransfer-iOS-CI repo
    inputs:
    - content: |-
        #!/bin/bash
        set -ex
        bitrise run --config ./Submodules/WeTransfer-iOS-CI/Bitrise/tag_releasing_bitrise.yml "${BITRISE_TRIGGERED_WORKFLOW_ID}"
```

After that, you can simply create a new tag and the whole release process will be triggered! 🚀

### 6: App deployment lanes
If you are building an app instead of a framework you can make use of the deployment lanes.

The `beta` lane takes care of:
- Generating a changelog based on the GH issues that were solved and PR's that were merged in since the last beta build.
- Create a draft release in GitHub.
- Create a new AppStore release candidate and upload it to TestFlight.

The `release` does the following:
- Fetch the lates green (approved) release from GitHub.
- Create a new release branch in GitHub.
- Create a PR that merges the release branch into the main branch.
- Create a PR that merges the release branch into develop in order to make sure that develop contains the updated changelog and incremented build number.
- Create a release build, upload it to TestFlight and submit for review.

These two lanes allow for the following workflow:
1. Use the `beta` lane to upload an AppStore Release Candidate to TestFlight.
2. Once the build went trough QA and has been approved for release mark it as green.
3. Submit a new build to the App Store using the `release` lane.

#### Marking a build as release ready
- Find the draft release matching the tested TestFlight build number at `http://github.com/{organization}/{repo}/releases`.
- Edit the draft and press the green button `Publish release`.

#### How to use this in your project?

Import the `deployment_lanes.rb` from this repo into the Fastfile. If you haven't done so already in step 2 also import the `shared_lanes` file.

```ruby
import "./../Submodules/WeTransfer-iOS-CI/Fastlane/deployment_lanes.rb"
```

Then you need to make sure to authenticate with App Store Connect before running the deployment lanes. This can be done by adding a `before_all` block, like so:

```ruby
before_all do |lane, options|
  authenticate
end
```

Then there is two ways you can start using the deployment lanes. The first one is to create a new lane in the Fastfile from which you call one of the deployment lanes specifying values for all the options. The other option is to use environment variables, for example by using a .env file. In that case the lanes can be called directly without passing any options. An example of a .env file can be found [here](sample_fastlane_env).

### 7: Provisioning lanes

The provisioning lanes help you with provisioning related task such as code signing and device management. To use them all you need to do is import `provisioning_lanes.rb` from this repo into the Fastfile.

## License
WeTransfer-iOS-CI is available under the MIT license. See the LICENSE file for more info.
