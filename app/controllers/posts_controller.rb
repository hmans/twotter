class PostsController < ApplicationController
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post.user
    else
      render :new
    end
  end


  private

  def post_params
    params.require(:post).permit(:body)
  end
end
