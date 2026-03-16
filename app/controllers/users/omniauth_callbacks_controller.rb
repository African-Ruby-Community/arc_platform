# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # Handles successful GitHub OAuth authentication
    def github
      auth_data = request.env['omniauth.auth']

      # Handle case where auth data is completely missing
      if auth_data.blank?
        redirect_to root_path, alert: 'Authentication failed. Please try again.'
        return
      end

      @user = User.from_omniauth(auth_data)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
      else
        # Store OAuth data in session for potential retry
        session['devise.github_data'] = auth_data.except(:extra)
        redirect_to new_user_registration_url, alert: 'There was an error creating your account. Please try again.'
      end
    end

    # Handles OAuth authentication failures
    def failure
      # Log the failure for debugging (optional)
      Rails.logger.warn "OAuth authentication failed: #{failure_message}"

      # Redirect to root with appropriate error message
      redirect_to root_path, alert: 'Authentication failed. Please try again or use email/password login.'
    end

    private

    # Extract failure message from omniauth failure
    def failure_message
      request.env['omniauth.error']&.message || 'Unknown error'
    end
  end
end
