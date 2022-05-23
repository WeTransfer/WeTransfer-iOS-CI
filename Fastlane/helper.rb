# rubocop:disable Layout/LineLength

## Helper

# Checks if the current environment is CI.
def is_running_on_CI(options)
  options[:ci] || ENV['CI'] == 'true'
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
# * tag_name - adds the tag name at the end of the given slack message.
# * success - was this build successful? (true/false) Default is true.
# * default_payloads - Specifies default payloads to include. Pass an empty array to suppress all the default payloads ([:git_branch]).
# * release_url - URL to be added as payload.
def slack_message(message, options = {})
  return if message.empty?

  slack_message = message << (options[:tag_name] && !options[:tag_name].empty? ? " (#{options[:tag_name]})" : "")
  slack_success = !!options[:success] == options[:success] ? options[:success] : true
  default_payloads = options[:default_payloads] ? options[:default_payloads] : [:git_branch]
  slack_payload = {}
  slack_payload['Release URL'] = options[:release_url] if options[:release_url] && !options[:release_url].empty?

  slack(
    message: slack_message,
    success: slack_success,
    default_payloads: default_payloads,
    payload: slack_payload
  )
end
