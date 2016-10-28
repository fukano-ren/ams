require 'test_helper'

class PasschenControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
