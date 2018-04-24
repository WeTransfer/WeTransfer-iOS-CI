require 'bundler/setup'
require 'pry'
require 'danger'
require 'cork'
require 'danger_plugin'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true
end

RSpec::Matchers.define :including do |x|
  match { |actual| actual.include? x }
end

# A silent version of the user interface
def testing_ui
  Cork::Board.new(silent: true)
end

# Example environment (ENV) that would come from
# running a PR on TravisCI
def testing_env
  {
    'HAS_JOSH_K_SEAL_OF_APPROVAL' => 'true',
    'TRAVIS_PULL_REQUEST' => '800',
    'TRAVIS_REPO_SLUG' => 'WeTransfer/WeTransfer-iOS-CI',
    'TRAVIS_COMMIT_RANGE' => '759adcbd0d8f...13c4dc8bb61d',
    'DANGER_GITHUB_API_TOKEN' => '123sbdq54erfsd3422gdfio'
  }
end

# A stubbed out Dangerfile for use in tests
def testing_dangerfile
  env = Danger::EnvironmentManager.new(testing_env)
  Danger::Dangerfile.new(env, testing_ui)
end
