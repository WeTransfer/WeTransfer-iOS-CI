require File.expand_path('../spec_helper', __FILE__)
require File.expand_path('../../ext/git_swift_linter', __FILE__)

describe GitSwiftLinter do
  before do
    @gitswiftlinter = GitSwiftLinter.new(testing_dangerfile)
  end

  describe :lint do
    after(:each) do
      ENV['PROJECT_NAME'] = nil
    end

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

    it 'Warns when tests are not updated' do
      ENV['PROJECT_NAME'] = 'Coyote'

      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.git).to receive(:lines_of_code).and_return(30)

      expect(@gitswiftlinter.danger_file).to receive(:warn).with('Tests were not updated')

      @gitswiftlinter.updated_tests
    end

    it 'Warns when tests are not updated only if more than 20 lines of code' do
      ENV['PROJECT_NAME'] = 'Coyote'

      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['Coyote/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.git).to receive(:lines_of_code).and_return(10)

      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      @gitswiftlinter.updated_tests
    end

    it 'Does not warn when tests are updated' do
      ENV['PROJECT_NAME'] = 'Coyote'

      allow(@gitswiftlinter.danger_file.git).to receive(:modified_files).and_return(['CoyoteTests/file.swift'])
      allow(@gitswiftlinter.danger_file.git).to receive(:added_files).and_return([])
      allow(@gitswiftlinter.danger_file.git).to receive(:lines_of_code).and_return(30)

      expect(@gitswiftlinter.danger_file).not_to receive(:warn)

      @gitswiftlinter.updated_tests
    end
  end
end
