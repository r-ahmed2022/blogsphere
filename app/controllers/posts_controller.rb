class PostsController < ApplicationController
   load_and_authorize_resource
   before_action :set_post, only: %i[show edit update destroy]
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @likes = @posts.includes(:likes)
  end

  def show
    set_post
    #authorize! :show, @post
    rescue ActiveRecord::RecordNotFoundError
    redirect_to root_path
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to user_posts_path(current_user, @post)
    else
      render :new
    end
  end

  def edit
    set_post
    @form_url = user_post_path(@user, @post)
  end

  def update
    set_post
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to user_posts_path(current_user, @post)
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    set_post
    if @post.destroy
      flash[:notice] = 'Post was deleted successfully.'
      redirect_to user_posts_path
    else
      render 'Error', status: unprocessable_entity
    end
  end

  private

  def set_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
