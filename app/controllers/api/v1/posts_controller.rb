class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    user = User.find(params[:id])
    posts = user.posts
    render json: posts
  end
 end
