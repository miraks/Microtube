require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'A user' do
    setup do
      @user = Factory.create(:user)
    end

    context 'login' do
      should 'be unique' do
        @new_user.Factory.build(:user, login: @user.login)
        @new_user.save
        assert_contains(@new_user.errors.full_messages, "Login has already been taken")
      end

      should 'be readonly' do
        assert_raise(ActiveRecord::ActiveRecordError) do
          @user.update_attribute(:login, 'new_login')
        end
      end

      should 'not be too short' do
        @user = Factory.build(:user, login: 'log')
        @user.save
        assert_equal(["Login is too short (minimum is 4 characters)"], @user.errors.full_messages)
      end

      should 'not be too long' do
        @user = Factory.build(:user, login: 'l' * 17)
        @user.save
        assert_equal(["Login is too long (maximum is 16 characters)"], @user.errors.full_messages)
      end
    end
  end
end
