class PostsController < ApplicationController

  before_action :ensure_author, only: [:edit, :update]
  before_action :require_login, except: :show

  def ensure_author
    redirect_to new_session_url unless current_user.id == Sub.find(params[:id]).user_id
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :user_id)
  end
end
