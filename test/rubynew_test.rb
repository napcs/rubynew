require 'minitest/autorun'
require 'rubynew/project'

require 'pathname'
# Not really a unit test - more of an integration test.
class RubynewTest < MiniTest::Test

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
    assert File.exist?(File.join(@folder, "lib", "#{@folder}.rb"))
    assert File.exist?(File.join(@folder, "lib", @folder, "version.rb"))
    assert File.exist?(File.join(@folder, "test", "#{@folder}_test.rb"))
    assert File.exist?(File.join(@folder, "bin", "#{@folder}"))

  end

  def test_create_rakefile_with_test_task
    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "Rakefile"))
    assert file.read.include?("require \"rake/testtask\"")
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

  def test_has_bin

    Rubynew::Project.new(@folder).create

    file = Pathname.new(File.join(@folder, "bin", @folder))
    assert file.read.include?("$LOAD_PATH")
    assert file.read.include?("require 'tmpproject'")
  end
end
