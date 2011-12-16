class UsersController < ApplicationController
  before_filter :own_only, only: [:edit, :update, :destroy]

  helper_method :own_account?

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to @user, notice: 'Profile was successfully created'
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Profile was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_url
  end

  private

  def own_only
    redirect_to(root_url, notice: "You can change only your own account") unless own_account?
  end

  def own_account?
    return false unless current_session
    params[:id] == current_user.id.to_s
  end
end
