require 'test_helper'

class AdminLeelah::OrderManagement::OrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
