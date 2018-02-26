class PostsController < ApplicationController
  before_action :load_user

  def index
    @posts = @user ? @user.posts : Post.latest
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to @post.user
    else
      render :new
    end
  end


  private

  def load_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
