require 'test_helper'

class RepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reps_index_url
    assert_response :success
  end

end
