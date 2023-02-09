# rubocop:disable Layout/LineLength

require 'uri'

desc 'Runs tests for a specific package'
desc ''
desc '#### Options'
desc ' * **`package_name`**: The name of the package to test'
desc ' * **`package_path`**: The path to the package'
desc ''
lane :test_package do |options|
  UI.abort_with_message! "Package path is missing" unless options[:package_path]
  UI.abort_with_message! "Package name is missing" unless options[:package_name]
  test_project(options)
end

desc 'Runs tests for an external project'
desc ''
desc '#### Options'
desc " * **`scheme`**: The project's scheme"
desc ' * **`project_path`**: The path to the project'
desc ' * **`project_name`**: The name of the project'
desc ' * **`destination`**: ..'
lane :test_project do |options|
  # Set timeout to prevent xcodebuild -list -project to take to much retries.
  ENV['FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT'] = '30'
  ENV['FASTLANE_XCODE_LIST_TIMEOUT'] = '30'

  begin
    if options[:destination].nil?
      device = options[:device] || 'iPhone 14'
    end

    if options[:package_path].nil?
      project_path = "#{options[:project_path]}#{options[:project_name]}.xcodeproj"
    end

    scheme = options[:scheme] || options[:package_name]
    source_packages_dir = "#{ENV['PWD']}/.spm-build"
    
    # Setup Datadog CI Insights
    # configure_datadog_ci_test_tracing(
    #   service_name: scheme
    # )

    # Remove any leftover reports before running so local runs won't fail due to an existing file.
    sh("rm -rf #{ENV['PWD']}/build/reports/#{scheme}.xcresult")

    code_coverage_enabled = true

    if options.fetch(:build_for_testing, false)
      # The flag -enableCodeCoverage is only supported when testing.
      code_coverage_enabled = nil
    end

    scan(
      step_name: options[:step_name] || "Scan - #{scheme}",
      scheme: scheme,
      project: project_path,
      device: device,
      destination: options[:destination],
      code_coverage: code_coverage_enabled,
      disable_concurrent_testing: true, # As of 27th October 2021, this seems to not be working anymore. We need `parallel-testing-enabled NO` instead.
      fail_build: false,
      skip_slack: true,
      output_types: '',
      # xcodebuild_formatter: '', # Add this to get verbose logging by disabling xcbeautify.
      suppress_xcode_output: false,
      buildlog_path: ENV['BITRISE_DEPLOY_DIR'], # By configuring `BITRISE_DEPLOY_DIR` we make sure our build log is deployed and available in Bitrise.
      prelaunch_simulator: false,
      xcargs: "-clonedSourcePackagesDirPath #{source_packages_dir} -parallel-testing-enabled NO -retry-tests-on-failure -test-iterations 3 \"CODE_SIGNING_ALLOWED=NO\"",
      include_simulator_logs: false, # Needed for this: https://github.com/fastlane/fastlane/issues/8909
      result_bundle: true,
      output_directory: "#{ENV['PWD']}/build/reports/",
      derived_data_path: "#{ENV['PWD']}/build/derived_data", # Set buildlog and derived data path to fix permission issues on Bitrise.
      package_path: options[:package_path], # Optional path to the SPM package to test.
      build_for_testing: options.fetch(:build_for_testing, nil),
      test_without_building: options.fetch(:test_without_building, nil),
      disable_package_automatic_updates: true, # Makes xcodebuild -showBuildSettings more reliable too.
      skip_package_dependencies_resolution: options.fetch(:disable_automatic_package_resolution, false)
    )
  rescue StandardError => e
    if options.fetch(:raise_exception_on_failure, false)
      raise e
    else
      UI.important("Tests failed for #{e}")
    end
  end
end

desc 'Configures environment variables to enable Datadog CI Tests Tracing'
desc ''
desc 'To enable Datadog CI Tests Tracing for your project:'
desc ' 1. Add the DD_API_KEY env variable as a secret to Bitrise'
desc ' 2. Link the DatadogSDKTesting package following instructions here: https://docs.datadoghq.com/continuous_integration/setup_tests/swift/'
lane :configure_datadog_ci_test_tracing do |options|
  if ENV.include?("DD_API_KEY")
    ENV["TEST_RUNNER_DD_TEST_RUNNER"] = '1' 
    ENV["TEST_RUNNER_DD_ENV"] = 'ci' 
    ENV["TEST_RUNNER_DD_SITE"] = 'datadoghq.eu'
    ENV["TEST_RUNNER_DD_SERVICE"] = options[:service_name]
    ENV["TEST_RUNNER_DD_API_KEY"] = ENV['DD_API_KEY']
    ENV["TEST_RUNNER_SRCROOT"] = ENV['PWD']
    ENV["TEST_RUNNER_DD_TRACE_DEBUG"] = '1'
    ENV["TEST_RUNNER_DD_GIT_REPOSITORY_URL"] = ENV['GIT_REPOSITORY_URL']
    ENV["TEST_RUNNER_DD_GIT_BRANCH"] = ENV['BITRISE_GIT_BRANCH']
    ENV["TEST_RUNNER_DD_GIT_COMMIT_SHA"] = ENV['BITRISE_GIT_COMMIT']
    ENV["TEST_RUNNER_DD_GIT_COMMIT_MESSAGE"] = ENV['BITRISE_GIT_MESSAGE']
    ENV["TEST_RUNNER_DD_GIT_COMMIT_AUTHOR_NAME"] = ENV['GIT_CLONE_COMMIT_AUTHOR_NAME']
    puts "Configured Datadog CI tracing."
  else 
    puts "Datadog CI tracing not configured since DD_API_KEY is missing."
  end
end

desc 'Create a release from a tag triggered CI run'
lane :release_from_tag do
  # Get the latest tag, which is the new release that triggered this lane.
  sh('git fetch --tags origin master --no-recurse-submodules -q')

  latest_tag = ENV['BITRISE_GIT_TAG']

  # Create a release branch
  sh "git branch release/#{latest_tag} origin/master"
  sh "git checkout release/#{latest_tag}"
  sh "git merge -X theirs #{latest_tag}"

  release_output = sh('mint run --silent gitbuddy release -c "../Changelog.md"')
  release_url = URI.extract(release_output).find { |url| url.include? 'releases/tag' }
  puts "Created release with URL: #{release_url}"

  # Run only if there's a podspec to update
  if Dir['../*.podspec'].any?
    # Update the podspec. It finds the .podspec automatically in the current folder.
    version_bump_podspec(version_number: latest_tag)

    begin
      # Push the podspec to trunk
      pod_push
    rescue StandardError => e
      UI.important("Pod push failed: #{e}")
    end
  end

  # Push the changes to the branch
  sh('git commit -a -m "Created a new release"')
  sh("git push origin release/#{latest_tag}")

  # Create a pull request for master to include the updated Changelog.md and podspec
  create_pull_request(
    api_token: ENV['DANGER_GITHUB_API_TOKEN'],
    repo: git_repository_name,
    title: "Merge release #{latest_tag} into master",
    base: 'master', # The branch to merge the changes into.
    body: "Containing all the changes for our [**#{latest_tag} Release**](#{release_url})."
  )
end

desc 'Unhide dev dependencies for danger'
lane :unhide_spm_package_dev_dependencies do
  text = File.read('../Package.swift')
  new_contents = text.gsub('// dev ', '')

  # To write changes to the file, use:
  File.open('../Package.swift', 'w') { |file| file.puts new_contents }
end

desc 'Get all changed files in the current PR'
desc 'Requires that the enviroment contains a Danger GitHub API token `DANGER_GITHUB_API_TOKEN`'
desc ''
desc '#### Options'
desc ' * **`pr_id`**: The identifier of the PR that contains the changes.'
desc ''
lane :changed_files_in_pr do |options|
  origin_name = git_repository_name.split('/')
  organisation = origin_name[0]
  repository = origin_name[1]

  if options[:pr_id].nil?
    raise 'Missing PR ID input'
  elsif ENV['DANGER_GITHUB_API_TOKEN'].nil?
    raise "Missing 'DANGER_GITHUB_API_TOKEN' environment variable"
  end

  puts "Fetching changed files for PR #{options[:pr_id]} using token ...#{ENV['DANGER_GITHUB_API_TOKEN'].chars.last(5).join}"

  result = github_api(
    server_url: 'https://api.github.com',
    api_token: ENV['DANGER_GITHUB_API_TOKEN'],
    http_method: 'GET',
    path: "/repos/#{organisation}/#{repository}/pulls/#{options[:pr_id]}"
  )

  baseRef = result[:json]['base']['ref']

  # As CI fetches only the minimum we need to fetch the remote to make diffing work correctly.
  sh 'git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'
  sh 'git fetch --no-recurse-submodules --no-tags'
  sh "git diff --name-only HEAD origin/#{baseRef}"
end

desc 'Check whether any of the changes happened in the given path'
desc ''
desc '#### Options'
desc ' * **`path`**: The path in which to check for changed files'
desc ''
lane :pr_changes_contains_path do |options|
  changes_contains_path = options[:changed_files].include?(options[:path])

  if changes_contains_path
    puts "Changes found for path #{options[:path]}"
  elsif puts "No changes found for path #{options[:path]}"
  end

  changes_contains_path
end

# This block will get executed when an error occurs, in any of the blocks (before_all, the lane itself or after_all).
error do |lane, exception|
  handle_error(lane, exception)
end
