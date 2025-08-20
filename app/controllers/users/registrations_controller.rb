# frozen_string_literal: true

##
# Devise override Registration controller
module Users
  class RegistrationsController < Devise::RegistrationsController
    ##
    # Devise override Registration create action
    # allow_unathenticated_access only: [:new, :create]
    before_action :verify_turnstile, only: [:create]

    def create
      super do
        resource.users_chapters.create(chapter_id: params[:chapter_id], main_chapter: true) if resource.persisted?
      end
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
      flash.now[:alert] = I18n.t('turnstile.errors.registration_failed')
      render :new, status: :unprocessable_entity
    end
  end
end
