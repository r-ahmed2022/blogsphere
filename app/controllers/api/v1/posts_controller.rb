class Api::V1::PostsController < Api::V1::BaseController
  #protect_from_forgery with: :null_session
  # before_action :authenticate_user!
  # skip_before_action :authenticate_user!, if: -> { request.format.json? }

  def index
    user = User.find(params[:id])
    posts = user.posts
    render json: posts
  end

  private

end
