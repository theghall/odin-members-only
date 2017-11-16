class PostsController < ApplicationController
  include ApplicationHelper

  before_action :logged_in_user, only: [:new, :create ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    flagged =  post_params[:flagged] == 'true' ? true : false

    @post.update_attributes(flagged: flagged)

    redirect_to root_path
  end

  def show
  end

  private
  
    def post_params
      params.require(:post).permit(:title, :body, :flagged)
    end
end
