require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin = Admin.create(name: "Admin Test", email: "admin@email.com", password: "foobar", password_confirmation: "foobar")
    @manager = Manager.create(name: "Manager Test", email: "manager@email.com", password: "foobar", password_confirmation: "foobar")
    @coach = Coach.create(name: "Coach Test", email: "coach@email.com", password: "foobar", password_confirmation: "foobar", manager_id: @manager.id)
    @rep = Rep.create(name: "Rep Test", email: "rep@email.com", password: "foobar", password_confirmation: "foobar", manager_id: @manager.id, coach_id: @coach.id)
  end

  test "login attempt with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: ' ', password: ' '} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login as admin" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @admin.email, password: @admin.password} }
    assert_redirected_to admins_path
    follow_redirect!
    assert_template 'admins/index'
    assert_select 'h1', 'Admins#index'
  end

  test "login as manager" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @manager.email, password: @manager.password } }
    assert_redirected_to managers_path
    follow_redirect!
    assert_template 'managers/index'
    assert_select 'h1', 'Managers#index'
  end

  test "login as coach" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @coach.email, password: @coach.password } }
    assert_redirected_to coaches_path
    follow_redirect!
    assert_template 'coaches/index'
    assert_select 'h1', 'Coaches#index'
  end

  test "login as rep" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @rep.email, password: @rep.password } }
    assert_redirected_to reps_path
    follow_redirect!
    assert_template 'reps/index'
    assert_select 'h1', 'Reps#index'
  end
end
