ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  setup :activate_authlogic

  def login user
    logout
    UserSession.create user
  end

  def logout
    session = UserSession.find
    session.destroy if session
  end
end

# prevent Paperclip from actually saving files
module Paperclip
  class Attachment
    def save
      @queued_for_delete = []
      @queued_for_write = {}
      true
    end

    private

    def post_process_styles
      true
    end
  end
end

class File
  def to_tempfile
    Class.new do
      def size
        10000
      end

      def read
        ""
      end
    end.new
  end
end
