class PostsController < ApplicationController
  before_action :logged_in?, only: [:new, :create]

  def index
    @posts = Post.all
    @logged_in = logged_in?
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
