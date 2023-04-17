class ApplicationController < ActionController::Base
  before_action :authenticate_user! # All users should be authenticated in all controllers by default
  before_action :configure_permitted_parameters, if: :devise_controller?

  ##
  # CanCanCan permission exception capture
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      if user_signed_in?
        format.html { redirect_to root_path, alert: exception.message }
      else
        format.html { redirect_to root_path, alert: 'Please sign in to perform the action' }
      end
    end
  end

  protected

  ##
  # Add extra permitted parameters to User's model when devise controller is used
  def configure_permitted_parameters
    keys = %i[name phone_number github_username]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end
end
