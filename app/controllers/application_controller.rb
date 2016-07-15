class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_filter :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :email, :password, :password_confirmation, attachment_attributes: [:id, :image, :_destroy]])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, attachment_attributes: [:id, :image, :_destroy]])
  end
end
