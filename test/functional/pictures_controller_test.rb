require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_create_invalid
    Pictures.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Pictures.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pictures_url(assigns(:pictures))
  end
  
  def test_destroy
    pictures = Pictures.first
    delete :destroy, :id => pictures
    assert_redirected_to pictures_url
    assert !Pictures.exists?(pictures.id)
  end
  
  def test_show
    get :show, :id => Pictures.first
    assert_template 'show'
  end
end
