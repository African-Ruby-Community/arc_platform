# frozen_string_literal: true

require 'test_helper'

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @chapter = chapters(:one)
      @user_params = {
        email: 'test@example.com',
        name: 'Test User',
        phone_number: '1234567890',
        github_username: 'octocat',
        password: 'password123',
        password_confirmation: 'password123'
      }
      GithubAccountVerifier.stubs(:exists?).returns(true)
    end

    def test_user_can_register_with_valid_params
      with_turnstile(success: true) do
        assert_difference('User.count', 1) do
          post user_registration_path,
               params: { user: @user_params, chapter_id: @chapter.id, 'cf-turnstile-response': 'test-token' }
        end
      end
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_match I18n.t('devise.registrations.signed_up_but_unconfirmed'), response.body
    end

    def test_user_cannot_register_with_invalid_params
      invalid_params = @user_params.merge(password_confirmation: 'wrongpass')
      with_turnstile(success: true) do
        assert_no_difference('User.count') do
          post user_registration_path,
               params: { user: invalid_params, chapter_id: @chapter.id, 'cf-turnstile-response': 'test-token' }
        end
      end

      assert_response :unprocessable_entity
      assert_match 'error', response.body
    end
  end
end
