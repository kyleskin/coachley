require 'test_helper'

class CoachTest < ActiveSupport::TestCase
  def setup
    @coach = Coach.new(name: 'Coach 1', email: 'coach1@example.com', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @coach.valid?
  end

  test "name can't be blank" do
    @coach.name = " "
    assert_not @coach.valid?
  end

  test "email can't be blank" do
    @coach.email = " "
    assert_not @coach.valid?
  end

  test "name can't be longer than 50 characters" do
    @coach.name = 'a' * 51
    assert_not @coach.valid?
  end

  test "email can't be longer than 255 characters" do
    @coach.email = 'a' * 244 + '@example.com'
    assert_not @coach.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @coach.email = valid_address
      assert @coach.valid?, "#{valid_address.inspect} should be valid"
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
    duplicate_user = @coach.dup
    duplicate_user.email = @coach.email.upcase
    @coach.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = 'CoacH@exaMPle.cOm'
    @coach.email = mixed_case_email
    @coach.save
    assert_equal mixed_case_email.downcase, @coach.reload.email
  end

  test "password should not be blank" do
    @coach.password = @coach.password_confirmation = ' ' * 6
    assert_not @coach.valid?
  end

  test "password should be at least 6 characters" do
    @coach.password = @coach.password_confirmation = 'a' * 5
    assert_not @coach.valid?
  end

end
