class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @user = current_user
    @posts = @user.posts.includes(:comments)
    @likes = @posts.includes(:likes)
  end

  def show
    set_post
  rescue ActiveRecord::RecordNotFoundError
    redirect_to root_path
  end

  def new
    @post = current_user.posts.new
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
    @form_url = user_post_path(current_user, @post)
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
    if @post
      @post&.destroy
      flash[:notice] = 'Post was deleted successfully.'
      redirect_to user_posts_path(@user)
    else
      flash.now[:alert] = 'Error deleting post'
      render :show
    end
  end

  private

  def set_post
    @user = current_user

    if current_user&.id == params[:id].to_i
      @post = @user.posts.find_by(id: params[:id])
    else
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :text, commentscounter: 0, likescounter: 0)
  end
end
