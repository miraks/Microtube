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
