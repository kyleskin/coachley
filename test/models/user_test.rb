require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @rep = User.new(name: "Rep 1", email: "rep1@example.com", password: "foobar", password_confirmation: "foobar", role: 0)

    @coach = User.new(name: "Coach 1", email: "coach1@example.com", password: "foobar", password_confirmation: "foobar", role: 1)
  end

  test "should be valid" do
    assert @rep.valid?
  end

  test "name can't be blank" do
    @rep.name = ' '
    assert_not @rep.valid?
  end

  test "name can't be longer than 50 characters" do
    @rep.name = 'a' * 51
    assert_not @rep.valid?
  end

  test "email can't be blank" do
    @coach.email = ' '
    assert_not @coach.valid?
  end

  test "email can't be longer than 255 characters" do
    @coach.email = 'a' * 244 + '@example.com'
    assert_not @coach.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @rep.email = valid_address
      assert @rep.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @coach.email = invalid_address
      assert_not @coach.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @rep.dup
    duplicate_user.email = @rep.email.upcase
    @rep.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "ReP@Example.CoM"
    @rep.email = mixed_case_email
    @rep.save
    assert_equal mixed_case_email.downcase, @rep.reload.email
  end

  test "default role should be rep" do
    @rep.role = ''
    @rep.save
    assert_equal "rep", @rep.reload.role
  end

  test "password should not be blank" do
    @rep.password = @rep.password_confirmation = ' ' * 6
    assert_not @rep.valid?
  end

  test "password should be at least 6 characters" do
    @rep.password = @rep.password_confirmation = 'a' * 5
    assert_not @rep.valid?
  end
end
