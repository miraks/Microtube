class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user

  def current_session
    UserSession.find
  end

  def current_user
    current_session.user
  end

  def logged_in?
    current_session != nil
  end
end
