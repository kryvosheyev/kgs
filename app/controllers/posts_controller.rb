class PostsController < ApplicationController
  
  load_and_authorize_resource param_method: :project_params
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.includes(:user)
  end

  def show   
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

    private
    
    def post_params
      params.require(:post).permit(:title, :description, :user_id )
    end

    def find_post
      @post = current_user.posts.find(params[:id])
    end

end
