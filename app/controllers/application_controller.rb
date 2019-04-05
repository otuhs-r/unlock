class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.staging?
  helper_method :current_user

  def login_required
    @current_user = current_user
    redirect_to root_path, alert: 'ログインしてください' unless @current_user
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
