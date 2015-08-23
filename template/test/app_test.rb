require "minitest/autorun"
require "<%= @underscored_name %>"

class <%= @constant_name %>Test < Minitest::Test
  def test_fails
    flunk "Gotta write a test!"
  end
end
