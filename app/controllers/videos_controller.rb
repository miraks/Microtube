#encoding: utf-8

class VideosController < ApplicationController
  before_filter :has_upload_right, only: :new
  before_filter :own_only, only: [:edit, :update, :destroy]

  # GET /videos
  def index
    @videos = Video.page(params[:page]).order('created_at DESC')
  end

  # GET /videos/1
  def show
    @video = Video.find(params[:id])
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  def create
    params[:video][:user_id] = current_user.id
    @video = Video.new(params[:video])

    if @video.save
      redirect_to @video, notice: 'Видео успешно добавлено'
    else
      render action: "new"
    end
  end

  # PUT /videos/1
  def update
    @video = Video.find(params[:id])

    if @video.update_attributes(params[:video])
      redirect_to @video, notice: 'Видео успешно добавлено'
    else
      render action: "edit"
    end
  end

  # DELETE /videos/1
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to current_user
  end

  private

  def has_upload_right
    redirect_to(root_url, :notice => "You must log in first.") unless logged_in?
  end

  def own_only
    redirect_to(root_url, :notice => "You can change only your own videos.") unless own_video?
  end

  def own_video?
    return false unless current_session
    Video.find(params[:id]).user == current_user
  end
end
