require 'test_helper'

class MobileControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get social" do
    get :djs
    assert_response :success
  end

  test "should get spin" do
    get :spin
    assert_response :success
  end

  test "should get gift" do
    get :gift
    assert_response :success
  end

  test "should get club" do
    get :club
    assert_response :success
  end

end
