require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../Danger/ext/git_swift_linter', __FILE__)

describe GitSwiftLinter do
  before do
    @gitswiftlinter = GitSwiftLinter.new(testing_dangerfile)
  end

  describe :lint do
    it 'Warns for a big PR' do
      allow(@gitswiftlinter.danger_file.git).to receive(:lines_of_code).and_return(600)
      expect(@gitswiftlinter.danger_file).to receive(:warn).with('Big PR')
      @gitswiftlinter.lines_of_code
    end

    it 'Warns for small descriptions' do
      allow(@gitswiftlinter.danger_file.git).to receive(:lines_of_code).and_return(11)
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_body).and_return('ab')
      expect(@gitswiftlinter.danger_file).to receive(:warn).with('Please provide a summary in the Pull Request description')

      @gitswiftlinter.pr_description
    end

    it 'Warns for WIP labels' do
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_labels).and_return(['WIP'])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return(['Pull Request Title'])
      expect(@gitswiftlinter.danger_file).to receive(:warn).with('PR is classed as Work in Progress')

      @gitswiftlinter.work_in_progress
    end

    it 'Warns for [WIP] in PR titles' do
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_labels).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('Pull Request which is [WIP]')
      expect(@gitswiftlinter.danger_file).to receive(:warn).with('PR is classed as Work in Progress')

      @gitswiftlinter.work_in_progress
    end

    it 'Warns if no changelog entry is made while code files are changed' do
      allow(@gitswiftlinter.danger_file.github).to receive(:branch_for_base).and_return('master')
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Warns if no changelog entry is made while localizable files are changed' do
      allow(@gitswiftlinter.danger_file.github).to receive(:branch_for_base).and_return('develop')
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/Localizable.strings'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Does not warn if a changelog entry is made and code files are changed' do
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift', 'CHANGELOG.md'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).not_to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Does not warn if a changelog entry is not made and code files are changed but #trivial is in the title' do
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title #trivial')

      expect(@gitswiftlinter.danger_file).not_to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Does not warn if a changelog entry is added as a new file' do
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return(['CHANGELOG.md'])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).not_to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Does not warn if a changelog entry is not made and no code files are changed' do
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/travis.yml'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).not_to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Does not warn if a changelog entry is not made and target branch is not develop or master' do
      allow(@gitswiftlinter.danger_file.github).to receive(:branch_for_base).and_return('feature/accounts_syncing')
      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.github).to receive(:pr_title).and_return('PR Title')

      expect(@gitswiftlinter.danger_file).not_to receive(:fail)

      @gitswiftlinter.updated_changelog
    end

    it 'Warns for not using final with classes' do
      expect(@gitswiftlinter.danger_file).to receive(:warn).once

      filelines = [
        'protocol MyDelegate: class',
        'final func myMethod()',
        '// final comment',
        'class nonFinalClass'
      ]

      @gitswiftlinter.file_final_usage('CoyoteTests/file.swift', filelines)
    end

    it 'Does not warn if the final class rule is disabled' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'danger:disable final_class',
        'class nonFinalClass'
      ]

      @gitswiftlinter.file_final_usage('Coyote/file.swift', filelines)
    end

    it 'Does not warn for final class if "open" is used' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'open class nonFinalClass'
      ]

      @gitswiftlinter.file_final_usage('Coyote/file.swift', filelines)
    end

    it 'Does not warn for final class if used in comments' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'fatalError("Subclasses must implement `execute` without overriding super.")',
        '/**',
        'This class',
        '*/',
        '/// class',
        '// class'
      ]

      @gitswiftlinter.file_final_usage('Coyote/file.swift', filelines)
    end

    it 'Warns for unowned usage' do
      expect(@gitswiftlinter.danger_file).to receive(:warn).once

      filelines = [
        '[weak self]',
        '[unowned self] _ in'
      ]

      @gitswiftlinter.unowned_usage('Coyote/file.swift', filelines)
    end

    it 'Warns for empty override methods' do
      expect(@gitswiftlinter.danger_file).to receive(:warn).once

      filelines = [
        'override func viewDidLoad() {',
        'super.viewDidLoad()',
        '}'
      ]

      @gitswiftlinter.empty_override_methods('CoyoteTests/file.swift', filelines)
    end

    it 'Does not warn for empty override methods with closures' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'override func viewDidLoad() {',
        'super.viewDidLoad()',
        'guard let download = self.download else { return }',
        '}'
      ]

      @gitswiftlinter.empty_override_methods('CoyoteTests/file.swift', filelines)
    end

    it 'Warns for MARK: usage in big files' do
      expect(@gitswiftlinter.danger_file).to receive(:warn).once

      filelines = [
        'override func myMethod() {',
        'print("something")',
        '}'
      ]

      @gitswiftlinter.mark_usage('Coyote/file.swift', filelines, 2)
    end

    it 'Does not warn for MARK: usage in small files' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'override func myMethod() {',
        'print("something")',
        '}'
      ]

      @gitswiftlinter.mark_usage('Coyote/file.swift', filelines, 5)
    end

    it 'Does not warn for MARK: usage if it is used' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'MARK: methods',
        'override func myMethod() {',
        'print("something")',
        '}'
      ]

      @gitswiftlinter.mark_usage('Coyote/file.swift', filelines, 2)
    end

    it 'It does not warn for MARK: usage in big test files' do
      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      filelines = [
        'override func myMethod() {',
        'print("something")',
        '}'
      ]

      @gitswiftlinter.mark_usage('CoyoteTests/fileTests.swift', filelines, 2)
    end

    it 'Prints out the Bitrise build URL if it is set' do
      allow(ENV).to receive(:[]).with('BITRISE_BUILD_URL').and_return('https://www.fakeurl.com')

      expect(@gitswiftlinter.danger_file).to receive(:message).with('View more details on <a href="https://www.fakeurl.com" target="_blank">Bitrise</a>')

      @gitswiftlinter.show_bitrise_build_url
    end

    it 'Does not print out the Bitrise build URL if it is not set' do
      expect(@gitswiftlinter.danger_file).not_to receive(:message)

      @gitswiftlinter.show_bitrise_build_url
    end
  end
end
