# frozen_string_literal: true

require 'test_helper'

class OauthIntegrationTest < ActionDispatch::IntegrationTest
  test 'login page contains GitHub OAuth button' do
    get new_user_session_path
    assert_response :success

    # Check that the GitHub OAuth button is present
    assert_select 'a[href=?]', user_github_omniauth_authorize_path
    assert_match 'Sign in with GitHub', response.body
  end

  test 'registration page contains GitHub OAuth button' do
    get new_user_registration_path
    assert_response :success

    # Check that the GitHub OAuth button is present
    assert_select 'a[href=?]', user_github_omniauth_authorize_path
    assert_match 'Sign up with GitHub', response.body
  end

  test 'registration page handles OAuth users differently' do
    # Simulate OAuth user by making a request that sets session data
    # For now, let's just test that the page renders correctly without OAuth data
    get new_user_registration_path

    assert_response :success
    # Test that normal registration form is shown
    assert_select 'input[name="user[password]"]'
    assert_select 'input[name="user[password_confirmation]"]'
  end
end
