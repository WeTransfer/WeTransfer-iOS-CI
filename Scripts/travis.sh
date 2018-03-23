echo Running WeTransfer iOS CI
git submodule sync && git submodule update --init --recursive
brew update
brew outdated swiftlint || brew upgrade swiftlint
bundle install
bundle exec fastlane test project_name:$1