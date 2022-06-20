class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_beginning_of_week

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def after_sign_in_path_for(resource_or_scope)
    calendar_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password)}
  end

  def record_not_found
    render file: Rails.root.join('public/404.html'), layout: true, status: :not_found
  end
end
