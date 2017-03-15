require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  def setup
    @coach = Coach.new(name: "Example Coach", email: "coach@example.com",
                       password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @coach.valid?
  end

  test "name can't be blank" do
    @coach.name = ''
    assert_not @coach.valid?
  end

  test "email can't be blank" do
    @coach.email = ""
    assert_not @coach.valid?
  end

  test "name can't be too long" do
    @coach.name = 'a' * 51
    assert_not @coach.valid?
  end

  test "email can't be too long" do
    @coach.email = 'a' * 244 + '@example.com'
    assert_not @coach.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A-US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @coach.email = valid_address
      assert @coach.valid?, "#{valid_address} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@baz..edu foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @coach.email = invalid_address
      assert_not @coach.valid?, "#{invalid_address} should not be valid"
    end
  end

  test "email addresses should be unique" do
    duplicated_coach = @coach.dup
    duplicated_coach.email = @coach.email.upcase
    @coach.save
    assert_not duplicated_coach.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "CoacH@ExampLE.CoM"
    @coach.email = mixed_case_email
    @coach.save
    assert_equal mixed_case_email.downcase, @coach.reload.email
  end

  test "password should be present (nonblank)" do
    @coach.password = @coach.password_confirmation = ' ' * 6
    assert_not @coach.valid?
  end

  test "password should be at least 6 characters" do
    @coach.password = @coach.password_confirmation = 'a' * 5
    assert_not @coach.valid?
  end

end
