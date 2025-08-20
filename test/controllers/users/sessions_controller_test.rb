# frozen_string_literal: true

require 'test_helper'

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    def setup
      # Ensure we create a fully valid user (all required fields)
      @user = create_test_user
    end

    def sign_in_with_turnstile!(email:, password:)
      with_turnstile(success: true) do
        post user_session_path, params: {
          user: { email: email, password: password },
          'cf-turnstile-response': 'test-token'
        }
      end
    end

    def test_user_can_login_with_valid_credentials
      sign_in_with_turnstile!(email: @user.email, password: ActiveSupport::TestCase::TEST_PASSWORD)
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match 'Signed in successfully', response.body
    end

    def test_user_cannot_login_with_invalid_credentials
      sign_in_with_turnstile!(email: @user.email, password: 'wrong')
      assert_response :unprocessable_entity
      assert_select 'form#new_user'
    end

    def test_user_can_logout
      # Sign in first
      sign_in_with_turnstile!(email: @user.email, password: ActiveSupport::TestCase::TEST_PASSWORD)
      follow_redirect!
      delete destroy_user_session_path
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match I18n.t('devise.sessions.signed_out'), response.body
    end
  end
end
