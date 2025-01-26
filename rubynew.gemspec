# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubynew/version'

Gem::Specification.new do |spec|
  spec.name          = "rubynew"
  spec.version       = Rubynew::VERSION
  spec.authors       = ["Brian Hogan"]
  spec.email         = ["brianhogan@napcs.com"]
  spec.summary       = %q{Generate new Ruby projects with tests.}
  spec.description   = %q{Ruby project generator. Creates bin/, lib/ and test/ folders with a module and a Rakefile so you can quickly develop an app with tests.}
  spec.homepage      = "http://github.com/napcs/rubynew"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 3.0.0'

  spec.files         = [
                        "bin/rubynew",
                        "lib/rubynew.rb",
                        "lib/rubynew/version.rb",
                        "lib/rubynew/project.rb",
                        "template/Rakefile",
                        "template/bin/app",
                        "template/lib/app/version.rb",
                        "template/lib/app.rb",
                        "template/test/app_test.rb",
                        "template/test/test_helper.rb",
                        "template/Gemfile",
                        "template/README.md",
                        "template/LICENSE",
                        "test/rubynew_test.rb",
                        "Rakefile",
                        "Gemfile",
                        "README.md",
                        "rubynew.gemspec",
                        "LICENSE.txt"

                        ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency 'minitest-reporters', "~> 1.7"
end
