# Load Bundler and load all your gems
require "bundler/setup"

# Explicitly load any gems you need.

require "<%= @underscored_name %>/version"

module <%= @constant_name %>
  # Your code goes here...
  # Good place for your main application logic if this is a library.
  #
  # Create classes in the <%= @underscored_name %> folder and
  # be sure to create unit tests for them too.
end
