class PostsController < ApplicationController
  def create
    params[:post][:video_id] = params[:video_id]
    @post = Post.new(params[:post])

    flash[:notice] = "Comment successfully created" if @post.save

    redirect_to @post.video
  end
end
