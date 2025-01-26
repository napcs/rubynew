require 'rubynew/project'

require "test_helper"
require 'pathname'
# Not really a unit test - more of an integration test.
class RubynewTest < Minitest::Test

  def setup
    @folder = "tmpproject"
  end

  def teardown
    # Remove the folder at the end of
    # each test run so it's always cleared out
    FileUtils.rm_rf @folder
  end

  def test_create_project_dir
    Rubynew::Project.new(@folder).create

    assert File.exist?(File.join(@folder, "Rakefile"))
    assert File.exist?(File.join(@folder, "Gemfile"))
    assert File.exist?(File.join(@folder, "README.md"))
    assert File.exist?(File.join(@folder, "LICENSE"))
    assert File.exist?(File.join(@folder, "lib", "#{@folder}.rb"))
    assert File.exist?(File.join(@folder, "lib", @folder, "version.rb"))
    assert File.exist?(File.join(@folder, "test", "#{@folder}_test.rb"))
    assert File.exist?(File.join(@folder, "bin", "#{@folder}"))

  end

  def test_no_bin_option_skips_bin_creation
    Rubynew::Project.new(@folder, {no_bin: true}).create
    assert !File.exist?(File.join(@folder, "bin" ))
  end

  def test_create_rakefile_with_test_task
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "Rakefile"))
    assert file.read.include?("require \"minitest/test_task\"")
    assert file.read.include?("test/**/*_test.rb")
  end

  def test_class_has_constant_name
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "lib", "#{@folder}.rb"))
    assert file.read.include?("Tmpproject")
  end

  def test_version_has_module_name
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "lib", "#{@folder}", "version.rb"))
    assert file.read.include?("module Tmpproject")
  end

  def test_app_has_module_name
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "lib", "#{@folder}.rb"))
    assert file.read.include?("module Tmpproject")
  end

  def test_app_loads_version
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "lib", "#{@folder}.rb"))
    assert file.read.include?("require \"tmpproject/version\"")
  end

  def test_unit_test_loads_app
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "test", "#{@folder}_test.rb"))
    assert file.read.include?("require \"tmpproject\"")
  end

  def test_unit_test_creates_class
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "test", "#{@folder}_test.rb"))
    assert file.read.include?("class TmpprojectTest < Minitest::Test")
  end

  def test_prefixed_test_option_affects_test_name
    Rubynew::Project.new(@folder, {prefix_test: true}).create
    file = Pathname.new(File.join(@folder, "test", "test_#{@folder}.rb"))
    assert file.read.include?("class TmpprojectTest < Minitest::Test")
  end

  def test_prefixed_test_option_affects_rakefile
    Rubynew::Project.new(@folder, {prefix_test: true}).create
    file = Pathname.new(File.join(@folder, "Rakefile"))
    assert file.read.include?("test/**/test_*.rb")
  end

  def test_has_bin
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "bin", @folder))
    assert file.read.include?("$LOAD_PATH")
    assert file.read.include?("require 'tmpproject'")
  end

  def test_bin_displays_name_and_version
    Rubynew::Project.new(@folder).create
    file = Pathname.new(File.join(@folder, "bin", @folder))
    assert file.read.include?('tmpproject v#{Tmpproject::VERSION}')
  end

  def readme_has_project_name_as_header
    Rubynew::Project.new(@folder).create
    file = Pathname.new(File.join(@folder, "README.md"))
    assert file.read.include?("# tmpproject\n")
  end
end
