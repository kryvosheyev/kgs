class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  def index
    @posts = Post.empty_desc.all
  end

  def show
    @post = Post.find(params[:id])
  end
  def create
    if @post = Post.create(params[:post].permit(:title, :description, :user_id))
      redirect_to @post
    else
      render 'new'
    end
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update

    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render 'edit'
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end
end
