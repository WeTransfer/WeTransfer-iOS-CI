# Lints GIT Swift changes.
class GitSwiftLinter
  attr_accessor :danger_file

  def initialize(danger_file)
    @danger_file = danger_file
  end

  # Warn if we submitted a big PR.
  def lines_of_code
    danger_file.warn('Big PR') if danger_file.git.lines_of_code > 500
  end

  # Mainly to encourage writing up some reasoning about the PR, rather than just leaving a title.
  def pr_description
    danger_file.warn('Please provide a summary in the Pull Request description') if danger_file.github.pr_body.length < 3 && danger_file.git.lines_of_code > 10
  end

  # Make it more obvious that a PR is a work in progress and shouldn't be merged yet.
  def work_in_progress
    has_wip_label = danger_file.github.pr_labels.any? { |label| label.include? 'WIP' }
    has_wip_title = danger_file.github.pr_title.include? '[WIP]'

    danger_file.warn('PR is classed as Work in Progress') if has_wip_label || has_wip_title
  end

  # Verify whether the tests are updated with this PR.
  def updated_tests
    files = danger_file.git.added_files + danger_file.git.modified_files

    has_app_changes = !files.grep(/#{@project_name}/).empty?
    has_test_changes = !files.grep(/#{@project_name}Tests/).empty?

    danger_file.warn('Tests were not updated') if has_app_changes && !has_test_changes && danger_file.git.lines_of_code > 20
  end

  # Warn for not using final
  def file_final_usage(file, filelines)
    is_multiline_comment = false
    filelines.each_with_index do |line, index|
      is_multiline_comment = true if line.include?('/**')
      is_multiline_comment = false if line.include?('*/')

      break if line.include?('danger:disable final_class') || is_multiline_comment
      next unless should_be_final_class_line?(line)

      danger_file.warn('Consider using final for this class or use a struct (final_class)', file: file, line: index + 1)
    end
  end

  # Warn for unowned usage
  def unowned_usage(file, filelines)
    filelines.each_with_index do |line, index|
      next unless line.include?('unowned self')
      danger_file.warn('It is safer to use weak instead of unowned', file: file, line: index + 1)
    end
  end

  # Check for methods that only call the super class' method
  def empty_override_methods(file, filelines)
    filelines.each_with_index do |line, index|
      next unless line.include?('override') && line.include?('func') && filelines[index + 1].include?('super') && filelines[index + 2].include?('}') && !filelines[index + 2].include?('{')
      danger_file.warn('Override methods which only call super can be removed', file: file, line: index + 3)
    end
  end

  # Check for big classes without MARK: usage
  def mark_usage(file, filelines, minimum_lines_count)
    return false if File.basename(file).downcase.include?('test')
    return false if filelines.grep(/MARK:/).any? || filelines.count < minimum_lines_count
    danger_file.warn("Consider to place some `MARK:` lines for #{file}, which is over 200 lines big.")
  end

  def lint_files
    (danger_file.git.modified_files + danger_file.git.added_files).uniq.each do |file|
      next unless File.file?(file)
      next unless File.extname(file).include?('.swift')

      filelines = File.readlines(file)

      file_final_usage(file, filelines)
      unowned_usage(file, filelines)
      empty_override_methods(file, filelines)
      mark_usage(file, filelines, 200)
    end
  end

  # Helper methods
  # Returns true if the line includes a class definition
  def class_line?(line)
    line.include?('class') && !line.include?('func') && !line.include?('//') && !line.include?('protocol') && !line.include?('"')
  end

  # Returns true if the line should be a final class
  def should_be_final_class_line?(line)
    class_line?(line) && !line.include?('final') && !line.include?('open')
  end
end
