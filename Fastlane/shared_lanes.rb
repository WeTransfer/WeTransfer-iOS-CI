desc 'Executes a bash script that prepares for a CI run.'
desc ''
desc '#### Options'
desc ' * **`script`**: The path to the bash script that prepares for a CI run. (`PREPARE_CI_SCRIPT`)'
desc ''
lane :prepare_for_ci do |options|
  script = options[:script] || ENV['PREPARE_CI_SCRIPT']

  if script.nil?
    puts 'Did not find a script to prepare for a CI run.'
    next
  end

  sh(script)
end

desc 'Returns the repository name. E.g: WeTransfer/Mocker'
lane :git_repository_name do
  sh("git remote show origin -n | grep h.URL | sed 's/.*://;s/.git$//'").strip
end

desc 'Get latest release from Github. Draft releases and prereleases are not returned by this endpoint. See: https://developer.github.com/v3/repos/releases/#get-the-latest-release'
lane :latest_github_release do
  origin_name = git_repository_name.split('/')
  organisation = origin_name[0]
  repository = origin_name[1]

  result = github_api(
    server_url: 'https://api.github.com',
    api_token: ENV['DANGER_GITHUB_API_TOKEN'],
    http_method: 'GET',
    path: "/repos/#{organisation}/#{repository}/releases/latest"
  )

  puts "Latest Github release is #{result[:json]['tag_name']}"
  result[:json]['tag_name']
end

desc 'Runs danger locally for the given PR ID.'
lane :run_danger_locally do
  pr_id = prompt(text: 'Enter the pull request identifier: ', ci_input: "3")

  origin_name = git_repository_name.split('/')
  organisation = origin_name[0]
  repository = origin_name[1]

  ENV["BITRISE_IO"] = "random-value-does-not-matter"
  ENV["BITRISEIO_GIT_REPOSITORY_OWNER"] = organisation
  ENV["BITRISEIO_GIT_REPOSITORY_SLUG"] = repository
  ENV["BITRISE_PULL_REQUEST"] = pr_id

  # By changing directory into WeTransfer-iOS-CI, we can run Danger from there.
  # Caching is still done per repository which is why we add the build and cache paths.
  # --cwd makes sure to run Danger in the current repository directory
  # The Dangerfile.swift from within the WeTransfer-iOS-CI repo is used.
  #
  # This all allows us to not define Danger dependencies in every repo. It also optimises reusing the SPM cache on CI systems.
  sh("cd #{ENV['PWD']}/Submodules/WeTransfer-iOS-CI && danger-swift ci --cache-path ../../.build --build-path ../../.build --cwd ../../ --verbose")

  # Reset so that Fastlane don't thinks we're a CI anymore.
  ENV["BITRISE_IO"] = nil
end

## Helper

# Checks if the current environment is CI.
def is_running_on_CI(options = nil)
  (options != nil ? options[:ci] : false) || ENV['CI'] == 'true'
end

# Truncates a given string to a certain length and adds a truncation mark in the
# end if the string is long enough.
def truncate(string, max)
  return if string.empty?

  truncation_mark = '...'
  if string.length > max
    max > truncation_mark.length ? "#{string[0...max-truncation_mark.length]}#{truncation_mark}" : "#{string[0...max]}"
  else
    string
  end
end

# Posts a message about the status of a build to Slack.
# It is required to create an incoming Webhook for Slack and set this as an environment variable `SLACK_URL`.
#
# ==== Options
# * type - adds an emoji to easier identify the messages context ([:error, :info, :release_build, :submitted]).
# * tag_name - adds the tag name at the end of the given slack message.
# * success - was this build successful? (true/false) Default is true.
# * default_payloads - Specifies default payloads to include. Pass an empty array to suppress all the default payloads ([:git_branch]).
# * additional_payloads - Additional payloads to be added to the slack message. A hash is expected.
# * release_url - URL to be added as payload.
def slack_message(message, options = {})
  return if message.empty?

  supported_types = {
    error: ":x: ",
    info: ":information_source: ",
    release_build: ":tada: ",
    submitted: ":rocket: "
  }

  slack_message_tag = " (#{options[:tag_name]})" if options[:tag_name] && !options[:tag_name].empty?
  slack_message = "#{supported_types[options[:type]]}#{message}#{slack_message_tag}"
  slack_success = !!options[:success] == options[:success] ? options[:success] : true
  default_payloads = options[:default_payloads] ? options[:default_payloads] : [:git_branch]
  slack_payload = {}
  slack_payload['Release URL'] = options[:release_url] if options[:release_url] && !options[:release_url].empty?
  slack_payload.merge!(options[:additional_payloads]) if options[:additional_payloads]

  slack(
    message: slack_message,
    success: slack_success,
    default_payloads: default_payloads,
    payload: slack_payload
  )
end

lane :clean_up_release_from_tag do |options|
  latest_tag = ENV['BITRISE_GIT_TAG']

  latest_release_branch = "release/#{latest_tag}"
  if `git ls-remote --heads origin #{latest_release_branch}`.empty?
    UI.message "Branch #{latest_release_branch} doesn't exist. Nothing to delete."
  else
    sh "git push origin --delete #{latest_release_branch}"
  end

  if `git ls-remote --tags origin #{latest_tag}`.empty?
    UI.message "Tag #{latest_tag} doesn't exist. Nothing to delete."
  else
    sh "git push origin --delete #{latest_tag}"
  end
end

# Shared method for handling errors that are being raised during fastlane deployment.
# Errors being raised on the test lane (PR tests) will be ignore, because they could lead to too much spam on the slack channel.
def handle_error(lane, exception)
  return if lane == :test # Do not report errors on PR tests.
  return unless is_running_on_CI # Do not report errors on other environments than CI.

  # Makes sure we clean up the tag and the release branch if release_from_tag failed, to allow future releases
  clean_up_release_from_tag if lane == :release_from_tag

  slack_message(
    "Something went wrong with the deployment on lane: #{lane}.",
    type: :error,
    success: false,
    additional_payloads: {
      "Bitrise build" => ENV['BITRISE_BUILD_URL'],
      "Error Info" => exception.to_s
    }
  )
end
