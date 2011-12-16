class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_to @user_session.user, notice: 'Successfully logged in'
    else
      render action: 'new'
    end
  end

  def destoy
    @user_session = current_session
    if @user_session
      @user_session.destroy
      flash[:notice] = 'Successfully logged out'
    end
    redirect_to root_url
  end
end
