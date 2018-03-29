# GIT Warnings and errors report of the lint.
class GitSwiftLinterReport

  attr_accessor :warnings, :errors

  def initialize(warnings, errors)
    @warnings = warnings
    @errors = errors
  end
end

# Lints GIT Swift changes.
class GitSwiftLinter
  attr_accessor :danger_file

  def initialize(danger_file)
    @danger_file = danger_file
  end

  def lint
    warnings = []

    warnings.push("Big PR") if danger_file.git.lines_of_code > 500

    return GitSwiftLinterReport.new(warnings, [])
  end

  # Warn if we submitted a big PR.
  def lines_of_code
    danger_file.warn("Big PR") if danger_file.git.lines_of_code > 500
  end

  # Mainly to encourage writing up some reasoning about the PR, rather than just leaving a title.
  def pr_description
    danger_file.warn("Please provide a summary in the Pull Request description") if danger_file.github.pr_body.length < 3 && danger_file.git.lines_of_code > 10
  end

  # Make it more obvious that a PR is a work in progress and shouldn't be merged yet.
  def work_in_progress
    has_wip_label = danger_file.github.pr_labels.any? { |label| label.include? "WIP" }
    has_wip_title = danger_file.github.pr_title.include? "[WIP]"

    danger_file.warn("PR is classed as Work in Progress") if has_wip_label || has_wip_title
  end
end
