require 'test_helper'

class AdminLeelah::CatalogManagement::ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
