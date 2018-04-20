# Disable linting of Dangerfile.
# rubocop:disable all

has_app_changes = !git.modified_files.grep(/(bin|ext|lib)/).empty?

warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

warn("Big PR, try to keep changes smaller if you can") if git.lines_of_code > 500

rubocop.lint

junit.parse "junit-results.xml"

if junit.failures.empty? 
  message "All tests succeeded"
end

junit.report