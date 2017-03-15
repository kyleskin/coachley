require 'test_helper'

class RepTest < ActiveSupport::TestCase

  def setup
    @rep = Rep.new(name: "Example Rep", email: "rep@example.com",
                   password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @rep.valid?
  end

  test "name can't be blank" do
    @rep.name = ""
    assert_not @rep.valid?
  end

  test "email can't be blank" do
    @rep.email = ""
    assert_not @rep.valid?
  end

  test "name can't be too long" do
    @rep.name = "a" * 51
    assert_not @rep.valid?
  end

  test "email can't be too long" do
    @rep.email = "a" * 244 + "@example.com"
    assert_not @rep.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A-US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @rep.email = valid_address
      assert @rep.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@baz..edu foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @rep.email = invalid_address
      assert_not @rep.valid?, "#{invalid_address} should not be valid"
    end
  end

  test "email addresses should be unique" do
    duplicated_rep = @rep.dup
    duplicated_rep.email = @rep.email.upcase
    @rep.save
    assert_not duplicated_rep.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "ReP@ExamPLE.com"
    @rep.email = mixed_case_email
    @rep.save
    assert_equal mixed_case_email.downcase, @rep.reload.email
  end

  test "password should be present (nonblank)" do
    @rep.password = @rep.password_confirmation = ' ' * 6
    assert_not @rep.valid?
  end

  test "password should be at least 6 characters" do
    @rep.password = @rep.password_confirmation = ' ' * 5
    assert_not @rep.valid?
  end
end
