require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  context 'The post controller' do
    setup do
      @post = Factory.build(:post)
      @video = Factory.create(:video)
    end

    context 'create action' do
      should 'create post' do
        assert_difference("@video.posts.count", 1) do
          post :create, video_id: @video.to_param, post: @post.attributes
        end
      end
    end
  end
end
