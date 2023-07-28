class Api::V1::PostsController < ApplicationController
  protect_from_forgery with: :null_session
  #before_action :authenticate_user!
  #skip_before_action :authenticate_user!, if: -> { request.format.json? }

  def index
    user = User.find(params[:id])
    posts = user.posts
    render json: posts
  end
  
  private

  def handle_unauthorized_access
    render json: { errors: ['You need to sign in or sign up before continuing.'] }, status: :unauthorized
  end
end
