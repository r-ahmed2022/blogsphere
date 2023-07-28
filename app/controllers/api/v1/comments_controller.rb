class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:index, :create]

  def index
    comments = @post.comments
    render json: comments
  end

  def create
    comment = @post.comments.build(comment_params)
    comment.user = current_user # Assuming you have implemented current_user method for authentication.
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end