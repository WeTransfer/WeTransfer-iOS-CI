# WeTransfer-iOS-CI
Containing all the shared CI logic for WeTransfer repositories

# Features
- Integrate [SwiftLint](https://github.com/realm/SwiftLint) to lint source code and tests. We have a different config for tests to allow unwrapping for example
- Integrate [Danger](http://danger.systems/) to automatically improve PR reviews

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

  scan(
    scheme: options[:project_name],
    project: "#{options[:project_name]}.xcodeproj",
    device: "iPhone 7",
    clean: true,
    code_coverage: true,
    formatter: "xcpretty-json-formatter"
  )

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

### 4: Run fastlane
You can now run fastlane using your CI environment. This can be integrated easily using the script in this repo:

```
- "./Submodules/WeTransfer-iOS-CI/Scripts/travis.sh PROJECT_NAME" # Run WeTransfer iOS CI Travis script
```

_Note: replace **PROJECT\_NAME** with your project name_

## License

UINotifications is available under the MIT license. See the LICENSE file for more info.

