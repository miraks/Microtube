require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  context 'A video' do
    setup do
      @video = Factory.create(:video)
    end

    context 'title' do
      should 'be updated' do
        new_title = 'new video title'
        @video.update_attribute(:title, new_title)
        @video.save
        @video.reload
        assert_equal(@video.title, new_title)
      end

      should 'not be too short' do
        @video.update_attribute(:title, 't')
        @video.save
        assert_equal(['Title is too short (minimum is 5 characters)'], @video.errors.full_messages)
      end

      should 'not be too long' do
        @video.update_attribute(:title, 't' * 101)
        @video.save
        assert_equal(['Title is too long (maximum is 100 characters)'], @video.errors.full_messages)
      end
    end

    context 'description' do
      should 'not be too long' do
        @video.update_attribute(:description, 'd' * 1001)
        @video.save
        assert_equal(['Description is too long (maximum is 1000 characters)'], @video.errors.full_messages)
      end
    end

    context 'video' do
      should 'present' do
        @video.video = nil
        assert(@video.invalid?)
      end

      should 'be correct' do
        @video = Factory.build(:video)
        @video.save
        assert_empty(@video.errors)
      end

      should 'fail conversion' do
        @video = Factory.build(:fake_video)
        @video.save
        assert_equal(["Video error while converting your video", "Video content type invalid"], @video.errors.full_messages)
      end
    end
  end
end
