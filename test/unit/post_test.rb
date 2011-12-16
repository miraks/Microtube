require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'A post' do
    setup do
      @post = Factory.build(:post)
    end

    context 'message' do
      should 'not be too long' do
        @post.message = 'm' * 501
        @post.save
        assert_equal(["Message is too long (maximum is 500 characters)"], @post.errors.full_messages)
      end
    end

    context 'name' do
      should 'set default name' do
        @post.name = ""
        @post.save
        assert_equal('Anonymous', @post.name)
      end

      should 'not be too long' do
        @post.name = 'n' * 21
        @post.save
        assert_equal(["Name is too long (maximum is 20 characters)"], @post.errors.full_messages)
      end
    end
  end
end
