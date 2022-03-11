# rubocop:disable Layout/LineLength

require 'spaceship'
require 'uri'
require 'json'

desc 'Creates a new release candidate'
desc ''
desc '- Creates a new TestFlight build including the unreleased changelog'
desc '- Creates a Github Draft Release including the unreleased changelog'
desc ''
desc '#### Options'
desc 'It is recommended to manage these options through a .env file.'
desc ' * **`app_identifier`**: The bundle identifier of the main app. (`APP_IDENTIFIER`)'
desc ' * **`app_identifiers`**: A comma separated string containing all bundle identifiers, e.g. app + extensions. (APP_IDENTIFIERS)'
desc ' * **`xcodeproj`**: The path to the Xcode project file. (`XCODEPROJ`)'
desc ' * **`target`**: The target to build. (`XCODE_TARGET`)'
desc " * **`scheme`**: The project's scheme. (`XCODE_SCHEME`)"
desc ' * **`xcconfig`**: A (optional) xcconfig file to use to build the app. (`BETA_XCCONFIG`)'
desc ' * **`team_id`**: The ID of your App Store Connect team. (`FASTLANE_ITC_TEAM_ID`)'
desc ' * **`contact_email`**: The contact email for beta review. (`BETA_CONTACT_EMAIL`)'
desc ' * **`contact_first_name`**: The first name of the contact for beta review. (`BETA_CONTACT_FIRST_NAME`)'
desc ' * **`contact_last_name`**: The last name of the contact for beta review. (`BETA_CONTACT_LAST_NAME`)'
desc ' * **`contact_phone`**: The phone number of the contact for beta review. (`BETA_CONTACT_PHONE`)'
desc ' * **`demo_account_name`**: The name of the demo account for beta review. (`BETA_DEMO_ACCOUNT_NAME`)'
desc ' * **`demo_account_password`**: The passwords for the demo account for beta review. (`BETA_DEMO_ACCOUNT_PASSWORD`)'
desc ' * **`groups`**: A list of TestFlight groups that should get access to the beta build. (`TESTFLIGHT_GROUPS_BETA`)'
lane :beta do |options|
  xcodeproj = options[:xcodeproj] || ENV['XCODEPROJ']
  target = options[:target] || ENV['XCODE_TARGET']
  scheme = options[:scheme] || ENV['XCODE_SCHEME']

  if is_changed_since_last_tag == false
    tag_name = create_tag_name(xcodeproj: xcodeproj, target: target)
    slack_message(message: 'A new Release is cancelled as there are no changes since the last available tag.', tag_name: tag_name)
  else
    clear_derived_data
    build_number = update_build_number(xcodeproj: xcodeproj, target: target)
    tag_name = create_tag_name(xcodeproj: xcodeproj, target: target)

    if options[:ci] || ENV['CI'] == 'true'
      certs(app_identifier: options[:app_identifiers] || ENV['APP_IDENTIFIERS'])
      prepare_for_ci
    end

    # Set timeout to prevent xcodebuild -list -project to take to much retries.
    ENV['FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT'] = '120'
    ENV['FASTLANE_XCODE_LIST_TIMEOUT'] = '120'

    gym(
      scheme: scheme,
      configuration: 'Release',
      xcconfig: options[:xcconfig] || ENV['BETA_XCCONFIG'],
      cloned_source_packages_path: 'SourcePackages'
    )

    # Refresh key as it's only valid for 20 minutes and gym can take a long time.
    authenticate(use_app_manager_role: true)

    # Create a new GitHub release
    last_non_candidate_tag = latest_github_non_candidate_tag
    release_title = "#{tag_name} - App Store Release Candidate"
    release_output = sh("mint run gitbuddy release -l #{last_non_candidate_tag} -b develop --skip-comments --json --use-pre-release --target-commitish develop --tag-name #{tag_name} --release-title '#{release_title}' --verbose")
    release_json = JSON.parse(release_output)

    release_url = release_json['url']
    changelog = release_json['changelog']
    stripped_changelog = strip_markdown_url(input: changelog)

    puts "Created release with URL: #{release_url}"

    begin
      testflight(
        beta_app_review_info: {
          contact_email: options[:contact_email] || ENV['BETA_CONTACT_EMAIL'],
          contact_first_name: options[:contact_first_name] || ENV['BETA_CONTACT_FIRST_NAME'],
          contact_last_name: options[:contact_last_name] || ENV['BETA_CONTACT_LAST_NAME'],
          contact_phone: options[:contact_phone] || ENV['BETA_CONTACT_PHONE'],
          demo_account_name: options[:demo_account_name] || ENV['BETA_DEMO_ACCOUNT_NAME'],
          demo_account_password: options[:demo_account_password] || ENV['BETA_DEMO_ACCOUNT_PASSWORD']
        },
        skip_waiting_for_build_processing: false,
        skip_submission: false,
        groups: options[:groups] || ENV['TESTFLIGHT_GROUPS_BETA'],
        changelog: stripped_changelog,
        team_id: options[:team_id] || ENV['FASTLANE_ITC_TEAM_ID']
      )
    rescue StandardError => e
      raise e unless e.message.include?('Another build is in review')

      UI.important('TestFlight delivery failed because a build is already in review, but continuing anyway!')
    end

    slack_message(message: 'A new Release Candidate has been published.', tag_name: tag_name, release_url: release_url)
  end
end

desc 'Creates a new App Store Release'
desc ''
desc '- Fetches the latest Github Release'
desc '- Merges the related tag into main'
desc '- Updates the changelog, creates a PR to develop for this as well'
desc '- Uses the changelog and creates a new Github App Store Release'
desc '- Submits the build to App Store Connect and TestFlight'
desc ''
desc '#### Options'
desc 'It is recommended to manage these options through a .env file. '
desc ' * **`app_identifier`**: The bundle identifier of the main app. (`APP_IDENTIFIER`)'
desc ' * **`app_identifiers`**: A comma separated string containing all bundle identifiers, e.g. app + extensions. (APP_IDENTIFIERS)'
desc ' * **`xcodeproj`**: The path to the Xcode project file. (`XCODEPROJ`)'
desc ' * **`target`**: The target to build. (`XCODE_TARGET`)'
desc " * **`scheme`**: The project's scheme. (`XCODE_SCHEME`)"
desc ' * **`xcconfig`**: The xcconfig file to use to build the app, optional. (`RELEASE_XCCONFIG`)'
desc ' * **`team_id`**: The ID of your App Store Connect team. (`FASTLANE_ITC_TEAM_ID`)'
desc ' * **`contact_email`**: The contact email for beta review. (`BETA_CONTACT_EMAIL`)'
desc ' * **`contact_first_name`**: The first name of the contact for beta review. (`BETA_CONTACT_FIRST_NAME`)'
desc ' * **`contact_last_name`**: The last name of the contact for beta review. (`BETA_CONTACT_LAST_NAME`)'
desc ' * **`contact_phone`**: The phone number of the contact for beta review. (`BETA_CONTACT_PHONE`)'
desc ' * **`demo_account_name`**: The name of the demo account for beta review. (`BETA_DEMO_ACCOUNT_NAME`)'
desc ' * **`demo_account_password`**: The passwords for the demo account for beta review. (`BETA_DEMO_ACCOUNT_PASSWORD`)'
desc ' * **`groups`**: A list of TestFlight groups that should get access to the beta build. (`TESTFLIGHT_GROUPS_RELEASE`)'
desc ' * **`hotfix`**: Whether the build is a hotfix release.'
desc ''
lane :release do |options|
  # Get the latest released tag, merge it into main and push it to remote.
  xcodeproj = options[:xcodeproj] || ENV['XCODEPROJ']
  target = options[:target] || ENV['XCODE_TARGET']
  scheme = options[:scheme] || ENV['XCODE_SCHEME']

  version_number = get_version_number(xcodeproj: xcodeproj, target: target)
  latest_release_tag = latest_github_release
  is_hotfix = options[:hotfix] || false

  begin
    unless is_hotfix
      ensure_release_is_needed(
        version_number: version_number,
        tag_name: latest_release_tag,
        app_identifier: options[:app_identifier] || ENV['APP_IDENTIFIER']
      )
    end

    sh "git fetch --tags origin #{ENV['BITRISE_GIT_BRANCH']} --no-recurse-submodules"

    branch_name = is_hotfix ? "hotfix/#{latest_release_tag}" : "release/#{latest_release_tag}"

    sh "git branch #{branch_name} origin/main"
    sh "git checkout #{branch_name}"

    sh "git merge -X theirs #{latest_release_tag}" unless is_hotfix

    # Update any new submodules
    sh 'git submodule sync && git submodule update --init --recursive && git submodule update --remote --no-fetch ../Submodules/WeTransfer-iOS-CI'

    update_build_number(xcodeproj: xcodeproj, target: target)
    last_non_candidate_tag = latest_github_non_candidate_tag

    # Create a new Github Release, which also merges the Changelog.md
    tag_name = create_tag_name(xcodeproj: xcodeproj, target: target)
    release_title = is_hotfix ? "#{tag_name} - App Store Hotfix Release" : "#{tag_name} - App Store Release"

    # Push the changes to our release branch so we can create a tag from it
    sh('git commit -a -m "Created a new release"')
    sh("git push origin #{branch_name}")

    release_latest_tag = is_hotfix ? latest_release_tag : last_non_candidate_tag
    release_base_branch = is_hotfix ? 'main' : 'develop'
    target_commitish = branch_name

    release_output = sh("mint run gitbuddy release -l #{release_latest_tag} -b #{release_base_branch} -c '../Changelog.md' --changelogToTag #{latest_release_tag} --target-commitish #{target_commitish} --tag-name #{tag_name} --release-title '#{release_title}' --json")
    release_json = JSON.parse(release_output)

    release_url = release_json['url']
    changelog = release_json['changelog']
    stripped_changelog = strip_markdown_url(input: changelog)

    puts "Created release with URL: #{release_url}"

    # Push the updated changelog.
    sh('git commit -a -m "Created a new release"')
    sh("git push origin #{branch_name}")

    repo = git_repository_name

    # Create a pull request for main to include the updated Changelog.md
    create_pull_request(
      api_token: ENV['DANGER_GITHUB_API_TOKEN'],
      repo: repo,
      title: "Merge release #{tag_name} into main",
      head: branch_name,
      base: 'main', # The branch to merge the changes into.
      body: "Containing all the changes for our latest release: [#{tag_name}](#{release_url})."
    )

    # Create a pull request for develop to include the updated Changelog.md
    create_pull_request(
      api_token: ENV['DANGER_GITHUB_API_TOKEN'],
      repo: repo,
      title: "Update Changelog in develop for latest release: #{tag_name}",
      head: branch_name,
      base: 'develop', # The branch to merge the changes into.
      body: "The changelog has been updated containing the changes from our latest release: [#{tag_name}](#{release_url})."
    )

    # Create and submit the actual build.
    clear_derived_data

    certs(app_identifier: options[:app_identifiers] || ENV['APP_IDENTIFIERS']) if options[:ci] || ENV['CI'] == 'true'

    prepare_for_ci

    # Set timeout to prevent xcodebuild -list -project to take to much retries.
    ENV['FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT'] = '120'
    ENV['FASTLANE_XCODE_LIST_TIMEOUT'] = '120'
    ENV['FASTLANE_XCODEBUILD_SETTINGS_RETRIES'] = '6'

    gym(
      scheme: scheme,
      configuration: 'Release',
      xcconfig: options[:xcconfig] || ENV['RELEASE_XCCONFIG'],
      cloned_source_packages_path: 'SourcePackages'
    )

    # Refresh key as it's only valid for 20 minutes and TestFlight can take a long time.
    authenticate(use_app_manager_role: true)

    stripped_changelog.prepend("This build has been submitted to the App Store.\n\n")
    testflight_groups = options[:groups] || ENV['TESTFLIGHT_GROUPS_RELEASE']

    puts "Creating a TestFlight build which will be available to these groups: #{testflight_groups}"

    testflight(
      beta_app_review_info: {
        contact_email: options[:contact_email] || ENV['BETA_CONTACT_EMAIL'],
        contact_first_name: options[:contact_first_name] || ENV['BETA_CONTACT_FIRST_NAME'],
        contact_last_name: options[:contact_last_name] || ENV['BETA_CONTACT_LAST_NAME'],
        contact_phone: options[:contact_phone] || ENV['BETA_CONTACT_PHONE'],
        demo_account_name: options[:demo_account_name] || ENV['BETA_DEMO_ACCOUNT_NAME'],
        demo_account_password: options[:demo_account_password] || ENV['BETA_DEMO_ACCOUNT_PASSWORD']
      },
      skip_waiting_for_build_processing: false,
      skip_submission: true,
      groups: testflight_groups,
      changelog: stripped_changelog,
      team_id: options[:team_id] || ENV['FASTLANE_ITC_TEAM_ID'],
      verbose: true
    )

    # Refresh key as it's only valid for 20 minutes and TestFlight can take a long time.
    authenticate(use_app_manager_role: true)

    # Use the latest TestFlight build and submit it for review.
    deliver(
      build_number: get_build_number(xcodeproj: xcodeproj).to_s,
      submit_for_review: true,
      team_id: options[:team_id] || ENV['FASTLANE_ITC_TEAM_ID'],
      force: true, # Skip HTMl report verification
      skip_binary_upload: true, # Not needed as we use the TestFlight build.
      phased_release: true,
      automatic_release: false,
      precheck_include_in_app_purchases: false,
      submission_information: {
        add_id_info_uses_idfa: false
      }
    )

    # Delete 1 pre-release found before the release we just created.
    # This is temporarily set to 1 to test out. We can eventually increase this number slowly
    # so we will eventually clean up all pre-releases.
    sh("mint run gitbuddy tagDeletion -u #{tag_name} -l 1 --prerelease-only --verbose")

    # Currently doesn't work because as you can't download dsyms with an API key
    # upload_dsyms

    release_type = is_hotfix ? 'hotfix' : 'release'
    slack_message(message: "A new #{release_type} has been submitted to the App Store.", tag_name: tag_name, release_url: release_url)
  rescue StandardError => e
    UI.error e
  end
end

desc 'Creates a hotfix using the release lane. Should always be called on the main branch.'
lane :hotfix do
  release(hotfix: true)
end

desc 'Create a build for running tests on browser stack'
lane :appium_build do |options|
  scheme = options[:scheme] || ENV['XCODE_SCHEME']
  clear_derived_data
  # Set timeout to prevent xcodebuild -list -project to take to much retries.
  ENV['FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT'] = '120'
  ENV['FASTLANE_XCODE_LIST_TIMEOUT'] = '120'

  certs(app_identifier: options[:app_identifiers] || ENV['APP_IDENTIFIERS'], type: 'development') if options[:ci] || ENV['CI'] == 'true'

  gym(
    scheme: scheme,
    configuration: 'Debug',
    export_method: 'development',
    xcconfig: options[:xcconfig] || ENV['BETA_XCCONFIG'],
    cloned_source_packages_path: '.build'
  )

  puts "IPA saved at #{ENV['IPA_OUTPUT_PATH']}"
end

desc 'Generates a JWT token used for JWT authorization with the App Store Connect API.'
desc 'The JWT token is added to the shared lane context so that it is automatically loaded into actions that require it.'
desc ''
desc '#### Options'
desc ' * **`use_app_manager_role`**: Whether it should use the token with the App Manager Role or Developer Role. This is needed when you want to upload build metadata in addition to a build to TestFlight'
desc ''
desc 'This lane makes use of the following environment variables:'
desc ' - `JWT_ISSUER_ID`: The identifier of the issuer of the JWT token'
desc ' - `APP_MANAGER_KEY_ID`: The id of the JWT token used to authenticate with an App manager role'
desc ' - `DEVELOPER_KEY_ID`: The id of the JWT token used to authenticate with a developer role'
desc ' - `APP_MANAGER_KEY_PATH`: The path to the file containing the private key'
desc ' - `DEVELOPER_KEY_PATH`: The path to the file containing the private key'
desc ''
lane :authenticate do |options|
  use_app_manager_role = options[:use_app_manager_role] || false
  key_id = use_app_manager_role ? ENV['APP_MANAGER_KEY_ID'] : ENV['DEVELOPER_KEY_ID']
  key_filepath = use_app_manager_role ? ENV['APP_MANAGER_KEY_PATH'] : ENV['DEVELOPER_KEY_PATH']
  issuer_id = ENV['JWT_ISSUER_ID']

  UI.important "Authenticating using #{use_app_manager_role ? 'App Manager Role' : 'Developer Role'}"

  app_store_connect_api_key(
    key_id: key_id,
    issuer_id: issuer_id,
    key_filepath: key_filepath,
    duration: 1200, # 90 minutes, matching Bitrise timeout limit.
    in_house: false # optional but may be required if using match/sigh
  )
end

desc 'Returns true if there are new changes since the last available tag'
private_lane :is_changed_since_last_tag do
  sh "git fetch --tags origin #{ENV['BITRISE_GIT_BRANCH']} --no-recurse-submodules"
  last_tag = last_git_tag
  changes = sh "git diff --name-only HEAD #{last_tag}"
  puts "Is local HEAD changed since last tag #{last_tag}: #{!changes.empty?}"
  is_changed = !changes.empty?
end

desc 'Updates the build number of the project based on the commit count'
desc ''
desc '#### Options'
desc ' * **`xcodeproj`**: the path to the Xcode project to read the version number from'
desc ' * **`target`**: The target within the project to read the version number from'
desc ''
private_lane :update_build_number do |options|
  # Get the path to the Xcode project and the target to read the version number from.
  xcodeproj = options[:xcodeproj]
  target = options[:target]

  # Compute a new build number based on the commit count.
  build = sh 'git rev-list --all --count'
  new_build_number = 200 + Integer(build)

  # Fetch the build number of the most recent test flight build, to make sure
  # that the new build number will be higher.
  version_number = get_version_number(xcodeproj: xcodeproj, target: target)
  latest_app_store_build_number = latest_testflight_build_number
  test_flight_build_number = latest_testflight_build_number(version: version_number)

  if new_build_number <= latest_app_store_build_number
    puts 'git build number is smaller than the build number of the latest release'
    puts "Using the latest release build number #{latest_app_store_build_number} + 1"
    new_build_number = latest_app_store_build_number + 1
  end

  if new_build_number <= test_flight_build_number
    puts 'git build number is smaller than test flight build number'
    puts "Using the TestFlight build number #{test_flight_build_number} + 1"
    new_build_number = test_flight_build_number + 1
  end

  increment_build_number(build_number: new_build_number)
end

desc 'Syncs production certificates on CI'
desc ''
desc '#### Options'
desc ' * **`app_identifier`**: a list of all app identifiers for which to sync the certs'
desc ''
private_lane :certs do |options|
  # Create Keychain to store certificates in
  create_keychain(
    name: ENV['MATCH_KEYCHAIN_NAME'],
    password: ENV['MATCH_KEYCHAIN_PASSWORD'],
    default_keychain: true,
    unlock: true,
    timeout: 3600,
    add_to_search_list: true
  )
  # Sync certificates
  match(
    keychain_name: (ENV['MATCH_KEYCHAIN_NAME']).to_s,
    keychain_password: (ENV['MATCH_KEYCHAIN_PASSWORD']).to_s,
    app_identifier: options[:app_identifier],
    force: true,
    type: options[:type] || 'appstore'
  )
end

desc "Fetch the version number that's currently in prepare for submission mode in App Store Connect."
desc ''
desc '#### Options'
desc ' * **`app_identifier`**: The bundle identifier of the app for which to fetch the preparing version number'
desc ''
private_lane :current_preparing_app_version do |options|
  puts 'fetching highest version on App Store Connect...'

  token = Spaceship::ConnectAPI::Token.create(Actions.lane_context[SharedValues::APP_STORE_CONNECT_API_KEY])
  Spaceship::ConnectAPI.token = token

  app = Spaceship::ConnectAPI::App.find(options[:app_identifier])

  if app.nil?
    puts 'App not found'
    next
  end

  if app.get_edit_app_store_version.nil?
    puts 'No preparing version number found'
    next
  end

  puts "Latest perparing version is #{app.get_edit_app_store_version.version_string}"

  app.get_edit_app_store_version.version_string
end

desc 'Ensures that a new release is allowed to happen'
desc ''
desc '#### Options'
desc ' * **`app_identifier`**: The bundle identifier of the app for which to fetch the preparing version number'
desc ' * **`version_number`**: The version number of the project'
desc ' * **`tag_name`**: The name of the latest release on GitHub'
desc ''
private_lane :ensure_release_is_needed do |options|
  preparing_app_version = current_preparing_app_version(app_identifier: options[:app_identifier])

  if preparing_app_version.nil?
    message = 'Weekly release cancelled as App Store Connect does not contain a preparing app version'
    UI.important message
    slack(
      message: message,
      success: false,
      default_payloads: %i[git_branch last_git_commit_message]
    )

    raise message
  end

  local_project_version_number = Gem::Version.new(options[:version_number])
  tag_version_number = Gem::Version.new(options[:tag_name].split('b')[0])

  app_store_preparing_version = Gem::Version.new(preparing_app_version)

  project_version_is_newer = tag_version_number < local_project_version_number
  preparing_version_is_newer = tag_version_number < app_store_preparing_version

  # Cancel when did not manage to create a stable release on GitHub or when the App Store Connect preparing version doesn't match the project version.
  if project_version_is_newer || preparing_version_is_newer
    UI.important "Release cancelled. Tag version: #{tag_version_number}, project version: #{local_project_version_number}, app store preparing version: #{app_store_preparing_version}"

    slack(
      message: 'Weekly released cancelled as no new green light build is available.',
      success: false,
      default_payloads: %i[git_branch last_git_commit_message],
      payload: {
        'Latest available release tag' => tag_version_number
      }
    )

    raise 'Weekly released cancelled as no new green light build is available.'
  end
end

desc 'Get latest release from Github that is not a prelease or release candidate'
private_lane :latest_github_non_candidate_tag do
  origin_name = git_repository_name.split('/')
  organisation = origin_name[0]
  repository = origin_name[1]

  # We set the page size to the max of 100 releaser per page so that as a quick way
  # of avoiding pagination. This gives us more than enough release candidates for weekly or
  # a bi-weekly build train. This lane will fail when there were more then 99 pre-releases published since the
  # latest release. Because then the results won't return the lates non candidate release and thus we don't know the tag.
  result = github_api(
    server_url: 'https://api.github.com',
    api_token: ENV['DANGER_GITHUB_API_TOKEN'],
    http_method: 'GET',
    path: "/repos/#{organisation}/#{repository}/releases?per_page=100"
  )
  latest_release = result[:json].find { |release| !release['name'].downcase.include? 'candidate' }
  latest_release['tag_name']
end

desc 'Strips Markdown URLs and returns it as plain text'
desc 'Used for example for the App Store changelog'
desc '#### Options'
desc ' * **`input`**: The text from which to strip the Markdown URLs'
desc ''
private_lane :strip_markdown_url do |options|
  options[:input].gsub(/(?:__|[*#])|\[(.*?)\]\(.*?\)/, '\1')
end

desc 'Generates a new tag name using the projects build and version number'
desc ''
desc '#### Options'
desc ' * **`xcodeproj**: The name of the Xcode project to use to get the build and version number'
desc ' * **`target`**: The Xcode target to use to get the build and version number'
desc ''
private_lane :create_tag_name do |options|
  version_number = get_version_number(xcodeproj: options[:xcodeproj], target: options[:target])
  build_number = get_build_number(xcodeproj: options[:xcodeproj])
  tag_name = version_number + 'b' + build_number
end
