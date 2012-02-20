require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get todos" do
    get :todos
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
