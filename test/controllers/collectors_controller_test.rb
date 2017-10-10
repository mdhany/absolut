require 'test_helper'

class CollectorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get event" do
    get :event
    assert_response :success
  end

end
