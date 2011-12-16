require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  context "The video controller" do
    setup do
      @video = Factory.create(:video)
      @user = Factory.create(:user)
      @owner = @video.user
      logout
    end

    teardown do
      logout
    end

    context 'index action' do
      should 'render' do
        get :index
        assert_response :success
      end
    end

    context 'show action' do
      should 'render' do
        get :show, id: @video.to_param
        assert_response :success
      end
    end

    context 'new action' do
      should 'redirect if not logged in' do
        get :new
        assert_equal("You must log in first.", flash[:notice])
      end

      should 'render' do
        login @user
        get :new
        assert_response :success
      end
    end

    context 'edit action' do
      should 'render' do
        login @owner
        get :edit, id: @video.to_param
        assert_response :success
      end
    end

    context 'update action' do
      should 'be updated' do
        login @owner
        old_title = @video.title
        put :update, id: @video.to_param, video: { title: 'new_title' }
        assert_redirected_to video_path(@video)
        @video.reload
        assert_not_equal(old_title, @video.title)
      end
    end

    context 'destroy action' do
      should 'be destroyed' do
        login @owner
        delete :destroy, id: @video.to_param
        assert_raise(ActiveRecord::RecordNotFound) do
          @video.reload
        end
      end
    end

    context 'owner restricts' do
      should 'be redirected' do
        {edit: :get, update: :put, destroy: :delete}.each do |method, action|
          send(action, method, id: @video.to_param)
          assert_redirected_to root_path

          login @user
          send(action, method, id: @video.to_param)
          assert_redirected_to root_path
          logout
        end
      end
    end
  end
end
