require 'test_helper'

class FollowersControllerTest < ActionController::TestCase
  def test_create_invalid
    Follower.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Follower.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    follower = Follower.first
    delete :destroy, :id => follower
    assert_redirected_to root_url
    assert !Follower.exists?(follower.id)
  end
end
