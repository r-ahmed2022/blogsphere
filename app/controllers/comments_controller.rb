class CommentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unauthorized_access
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_comments_path(current_user, @comment.post_id)
    else
      render :create
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = @comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment was deleted successfully.'
      redirect_to user_post_path
    else
      render 'Error', status: unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def handle_unauthorized_access
    render json: { errors: ['You need to sign in or sign up before continuing.'] }, status: :unauthorized
  end
end
