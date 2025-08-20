# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # invisible_captcha only: [:create], honeypot: :nickname
    before_action :verify_turnstile, only: :create

    def new
      self.resource = resource_class.new
      clean_up_passwords(resource)
      respond_with(resource, serialize_options(resource))
    end

    private

    def verify_turnstile
      token = params['cf-turnstile-response']
      return if TurnstileVerifier.new(token, request.remote_ip).verify

      handle_failed_turnstile_verification
    end

    def handle_failed_turnstile_verification
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      flash.now[:alert] = I18n.t('turnstile.errors.login_failed')
      render :new, status: :unprocessable_entity
    end
  end
end
