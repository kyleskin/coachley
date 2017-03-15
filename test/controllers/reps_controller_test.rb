require 'test_helper'

class RepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rep = reps(:one)
  end

  test "should get index" do
    get reps_url
    assert_response :success
  end

  test "should get new" do
    get new_rep_url
    assert_response :success
  end

  test "should create rep" do
    assert_difference('Rep.count') do
      post reps_url, params: { rep: { email: @rep.email, name: @rep.name } }
    end

    assert_redirected_to rep_url(Rep.last)
  end

  test "should show rep" do
    get rep_url(@rep)
    assert_response :success
  end

  test "should get edit" do
    get edit_rep_url(@rep)
    assert_response :success
  end

  test "should update rep" do
    patch rep_url(@rep), params: { rep: { email: @rep.email, name: @rep.name } }
    assert_redirected_to rep_url(@rep)
  end

  test "should destroy rep" do
    assert_difference('Rep.count', -1) do
      delete rep_url(@rep)
    end

    assert_redirected_to reps_url
  end
end
