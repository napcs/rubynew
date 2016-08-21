require 'erb'
require 'fileutils'

module Rubynew
  class Project

    def initialize(name)
      @name = name
      # ripped off from Bundler
      @underscored_name = @name.tr("-", "_")
      @constant_name = @name.gsub(/-[_-]*(?![_-]|$)/) { "::" }.gsub(/([_-]+|(::)|^)(.|$)/) { $2.to_s + $3.upcase }
    end

    def create
      template_path = File.expand_path("../../../template", __FILE__)

      # copy the template
      FileUtils.cp_r template_path, @name

      # rename the files
      FileUtils.mv File.join(@name, "lib", "app"), File.join(@name, "lib", @underscored_name)
      FileUtils.mv File.join(@name, "lib", "app.rb"), File.join(@name, "lib", "#{@underscored_name}.rb")
      FileUtils.mv File.join(@name, "test", "app_test.rb"), File.join(@name, "test", "#{@underscored_name}_test.rb")
      FileUtils.mv File.join(@name, "bin", "app"), File.join(@name, "bin", @underscored_name)

      # apply templates
      [
        File.join(@name, "bin",  @underscored_name),
        File.join(@name, "lib",  "#{@underscored_name}.rb"),
        File.join(@name, "lib",  @underscored_name, "version.rb"),
        File.join(@name, "test", "#{@underscored_name}_test.rb"),
        File.join(@name, "README.md")
      ].each { |file| render_template_to_file file, binding }

    end

    private

    def render_template_to_file(template, context)
      t = File.read(template)
      File.open(template, "w") do |f|
        f << ERB.new(t, nil, "-").result(context)
      end
    end

  end
end
