class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :email, :password, :password_confirmation, attachment_attributes: [:id, :image, :_destroy]])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :full_name
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [attachment_attributes: [:id, :image, :_destroy]])
  end
end
