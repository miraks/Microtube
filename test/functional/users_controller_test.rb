require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'The user controller' do
    setup do
      @user = Factory.create(:user)
      logout
    end

    teardown do
      logout
    end

    context 'show action' do
      should 'render' do
        get :show, id: @user.to_param
        assert_response :success
      end
    end

    context 'new action' do
      should 'render' do
        get :new
        assert_response :success
      end
    end

    context 'edit action' do
      should 'render' do
        login @user
        get :edit, id: @user.to_param
        assert_response :success
      end
    end

    context 'update action' do
      should 'be updated' do
        old_pass = @user.crypted_password
        login @user
        put :update, id: @user.to_param, user: { password: 'new_pass', password_confirmation: 'new pass' }
        assert_redirected_to user_path(@user)
        @user.reload
        assert_not_equal(old_pass, @user.crypted_password)
      end
    end

    context 'destroy action' do
      should 'be destroyed' do
        login @user
        delete :destroy, id: @user.to_param
        assert_raise(ActiveRecord::RecordNotFound) do
          @user.reload
        end
      end
    end

    context 'owner restricts' do
      should 'be redirected' do
        {edit: :get, update: :put, destroy: :delete}.each do |method, action|
          send(action, method, id: @user.to_param)
          assert_redirected_to root_path
        end
      end
    end
  end
end
