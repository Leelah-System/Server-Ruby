require 'test_helper'

class AdminLeelah::GeneralConfiguration::UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
