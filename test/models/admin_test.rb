require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def setup
    @admin = Admin.new(name: "Admin 1", email: "admin1@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "admin should be valid" do
    assert @admin.valid?
  end


  test "name can't be blank" do
    @admin.name = " "
    assert_not @admin.valid?
  end

  test "name can't be longer than 50 characters" do
    @admin.name = "a" * 51
    assert_not @admin.valid?
  end

  test "email can't be blank" do
    @admin.email = " "
    assert_not @admin.valid?
  end

  test "email can't be longer than 255 characters" do
    @admin.email = "a" * 244 + "@example.com"
    assert_not @admin.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @admin.email = valid_address
      assert @admin.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @admin.email = invalid_address
      assert_not @admin.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @admin.dup
    duplicate_user.email = @admin.email.upcase
    @admin.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = 'ReP@exaMPle.cOm'
    @admin.email = mixed_case_email
    @admin.save
    assert_equal mixed_case_email.downcase, @admin.reload.email
  end

  test "password should not be blank" do
    @admin.password = @admin.password_confirmation = ' ' * 6
    assert_not @admin.valid?
  end

  test "password should be at least 6 characters" do
    @admin.password = @admin.password_confirmation = 'a' * 5
    assert_not @admin.valid?
  end

end
