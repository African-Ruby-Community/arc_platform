# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    invisible_captcha only: [:create], honeypot: :nickname
  end
end
