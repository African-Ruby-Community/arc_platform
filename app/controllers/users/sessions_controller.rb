# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # invisible_captcha only: [:create], honeypot: :nickname
  end
end
