# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  #before_action :authenticate_user!
  #protect_from_forgery with: :null_session
  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unauthorized_access

  private

  def handle_unauthorized_access
    render json: { errors: ['You need to sign in or sign up before continuing.'] }, status: :unauthorized
  end
end
