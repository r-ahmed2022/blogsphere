class ApplicationController < ActionController::Base
  def index; end

  def current_user
    @current_user ||= User.first
  end
end
