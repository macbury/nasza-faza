require 'test_helper'

class PicturesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Pictures.new.valid?
  end
end
