# frozen_string_literal: true

##
# Devise override Registration controller
module Users
  class RegistrationsController < Devise::RegistrationsController
    ##
    # Devise override Registration create action
    # allow_unathenticated_access only: [:new, :create]
    before_action :verify_turnstile, only: [:create]
    before_action :populate_oauth_data, only: [:new]
    before_action :suppress_normal_signup_github_username, only: [:create]

    def create
      super do
        resource.users_chapters.create(chapter_id: params[:chapter_id], main_chapter: true) if resource.persisted?
      end
    end

    private

    def populate_oauth_data
      return unless session['devise.github_data']

      oauth_data = session['devise.github_data']
      # Initialize resource if it doesn't exist
      self.resource ||= resource_class.new

      resource.email = oauth_data['info']['email'] if oauth_data.dig('info', 'email')
      resource.name = oauth_data['info']['name'] if oauth_data.dig('info', 'name')
      resource.github_username = oauth_data['info']['nickname'] if oauth_data.dig('info', 'nickname')
    end

    def verify_turnstile
      token = params['cf-turnstile-response']
      return if TurnstileVerifier.new(token, request.remote_ip).verify

      handle_failed_turnstile_verification
    end

    def handle_failed_turnstile_verification
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      flash.now[:alert] = I18n.t('turnstile.errors.registration_failed')
      render :new, status: :unprocessable_content
    end

    # For normal (email/password) signups, drop any provided github_username so
    # users are not blocked by uniqueness constraints or external checks. OAuth
    # flow will still populate github_username via callback/session.
    def suppress_normal_signup_github_username
      return if session['devise.github_data'].present?

      # Remove github_username from the submitted params if present
      return unless params[:user].is_a?(ActionController::Parameters)

      params[:user].delete(:github_username)
    end
  end
end
