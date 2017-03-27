require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest

  def setup
    # @admin = Admin.create(name: "Admin Test", email: "admin@email.com", password: "foobar", password_confirmation: "foobar")
    # @manager = Manager.create(name: "Manager Test", email: "manager@email.com", password: "foobar", password_confirmation: "foobar")
    # @coach = Coach.create(name: "Coach Test", email: "coach@email.com", password: "foobar", password_confirmation: "foobar", manager_id: @manager.id)
    # @rep = Rep.create(name: "Rep Test", email: "rep@email.com", password: "foobar", password_confirmation: "foobar", manager_id: @manager.id, coach_id: @coach.id)
  end

  test "should get index" do
    get admins_path
    assert_response :success
  end

  test "all users should be displayed on index" do
    get admins_path
    assert_select 'h2', "Admin Test"
    assert_select 'h2', "Manager Test"
    assert_select 'h2', "Coach Test"
    assert_select 'h2', "Rep Test"
  end

end
