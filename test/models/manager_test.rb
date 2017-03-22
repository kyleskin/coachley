require 'test_helper'

class ManagerTest < ActiveSupport::TestCase

    def setup
      @manager = Manager.create(name: "Manager", email: "manager@email.com", password: "foobar", password_confirmation: "foobar")
    end

    test 'should be valid' do
      assert @manager.valid?
    end

    test "name can't be blank" do
      @manager.name = " "
      assert_not @manager.valid?
    end

    test "email can't be blank" do
      @manager.email = " "
      assert_not @manager.valid?
    end

    test "name can't be longer than 50 characters" do
      @manager.name = 'a' * 51
      assert_not @manager.valid?
    end

    test "email can't be longer than 255 characters" do
      @manager.email = 'a' * 244 + '@example.com'
      assert_not @manager.valid?
    end

    test "email validation should accept valid emails" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @manager.email = valid_address
        assert @manager.valid?, "#{valid_address.inspect} should be valid"
      end
    end

    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @manager.email = invalid_address
        assert_not @manager.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end

    test "email should be unique" do
      duplicate_user = @manager.dup
      duplicate_user.email = @manager.email.upcase
      @manager.save
      assert_not duplicate_user.valid?
    end

    test "email should be saved as lower-case" do
      mixed_case_email = 'CoacH@exaMPle.cOm'
      @manager.email = mixed_case_email
      @manager.save
      assert_equal mixed_case_email.downcase, @manager.reload.email
    end

    test "password should not be blank" do
      @manager.password = @manager.password_confirmation = ' ' * 6
      assert_not @manager.valid?
    end

    test "password should be at least 6 characters" do
      @manager.password = @manager.password_confirmation = 'a' * 5
      assert_not @manager.valid?
    end

end
