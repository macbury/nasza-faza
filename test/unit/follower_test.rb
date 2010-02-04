require 'test_helper'

class FollowerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Follower.new.valid?
  end
end
