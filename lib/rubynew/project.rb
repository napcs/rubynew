require 'erb'
require 'fileutils'

module Rubynew
  class Project

    def initialize(name, options={})
      @name = name
      # ripped off from Bundler
      @underscored_name = @name.tr("-", "_")
      @constant_name = @name.gsub(/-[_-]*(?![_-]|$)/) { "::" }.gsub(/([_-]+|(::)|^)(.|$)/) { $2.to_s + $3.upcase }
      @prefix_test = options[:prefix_test]
      @no_bin = options[:no_bin]

      @test_glob = if @prefix_test
                      "test/**/test_*.rb"
                   else
                      "test/**/*_test.rb"
                   end
    end

    def create
      template_path = File.expand_path("../../../template", __FILE__)

      # copy the template
      FileUtils.cp_r template_path, @name

      # rename the files
      FileUtils.mv File.join(@name, "lib", "app"), File.join(@name, "lib", @underscored_name)
      FileUtils.mv File.join(@name, "lib", "app.rb"), File.join(@name, "lib", "#{@underscored_name}.rb")

      if @no_bin
        FileUtils.rm_rf File.join(@name, "bin")
      else
        FileUtils.mv File.join(@name, "bin", "app"), File.join(@name, "bin", @underscored_name)
        # make bin executable
        FileUtils.chmod("+x", File.join(@name, "bin", @underscored_name))
      end


      # apply templates
      templates = [
        File.join(@name, "lib",  "#{@underscored_name}.rb"),
        File.join(@name, "lib",  @underscored_name, "version.rb"),
        File.join(@name, "README.md"),
        File.join(@name, "Rakefile")
      ]

      unless @no_bin
        templates << File.join(@name, "bin",  @underscored_name)
      end

      if @prefix_test
        FileUtils.mv File.join(@name, "test", "app_test.rb"), File.join(@name, "test", "test_#{@underscored_name}.rb")
        templates << File.join(@name, "test", "test_#{@underscored_name}.rb")
      else
        FileUtils.mv File.join(@name, "test", "app_test.rb"), File.join(@name, "test", "#{@underscored_name}_test.rb")
        templates << File.join(@name, "test", "#{@underscored_name}_test.rb")
      end

      templates.each { |file| render_template_to_file file, binding }

    end

    private

    def render_template_to_file(template, context)
      t = File.read(template)
      File.open(template, "w") do |f|
        f << ERB.new(t, trim_mode:"-").result(context)
      end
    end

  end
end
