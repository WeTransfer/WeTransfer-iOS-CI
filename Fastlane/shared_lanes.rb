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

desc 'Posts a message about the status of a build to Slack'
desc 'It is required to create an incoming Webhook for Slack and set this as an environment variable `SLACK_URL`'
desc ''
desc '#### Options'
desc ' * **`message**`: The message to post to Slack'
desc ' * **`tag_name**`: The name of the tag associated with the build'
desc ' * **`release_url`**: The url to a GH release.'
desc ''
lane :slack_message do |options|
  slack(
    message: "#{options[:message]} (#{options[:tag_name]})",
    success: true,
    default_payloads: %i[git_branch last_git_commit_message],
    payload: {
      'Release URL' => options[:release_url]
    }
  )
end
