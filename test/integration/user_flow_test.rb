# frozen_string_literal: true

require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  def setup
    # Use the helper to create a test user
    @user = create_test_user
  end

  def sign_in_with_turnstile(token: nil)
    post user_session_path, params: {
      user: { email: @user.email, password: ActiveSupport::TestCase::TEST_PASSWORD }
    }.merge(token ? { 'cf-turnstile-response': token } : {})
  end

  # Updated helper to stub the TurnstileVerifier instance verify method,
  # and to optionally stub site_key/secret_key if referenced by the view or verifier.
  def with_turnstile(success:, site_key: 'dummy-site-key', secret_key: 'dummy-secret-key')
    TurnstileVerifier.stubs(:site_key).returns(site_key)
    TurnstileVerifier.stubs(:secret_key).returns(secret_key)
    TurnstileVerifier.any_instance.stubs(:verify).returns(success)
    yield
  ensure
    TurnstileVerifier.unstub(:site_key)
    TurnstileVerifier.unstub(:secret_key)
    TurnstileVerifier.any_instance.unstub(:verify)
  end

  def test_sign_in_success_with_turnstile
    with_turnstile(
      success: true, site_key: '1x00000000000000000000AA', secret_key: '1x0000000000000000000000000000000AA'
    ) do
      sign_in_with_turnstile(token: 'valid-token')
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_match 'Signed in successfully', @response.body
  end

  def test_sign_in_fails_when_turnstile_verification_fails
    # Use the Cloudflare "fail" test keys for a failing Turnstile verification.
    with_turnstile(
      success: false, site_key: '2x00000000000000000000AB', secret_key: '2x0000000000000000000000000000000AA'
    ) do
      sign_in_with_turnstile(token: 'invalid-token')
    end

    assert_response :unprocessable_entity
    assert_select '.alert-error' do
      assert_select 'span', I18n.t('turnstile.errors.login_failed')
    end
    assert_select 'form#new_user'
  end

  def test_sign_in_fails_without_turnstile_token
    # Use the Cloudflare "fail" test keys and omit the token.
    with_turnstile(
      success: false, site_key: '2x00000000000000000000AB', secret_key: '2x0000000000000000000000000000000AA'
    ) do
      sign_in_with_turnstile # no token
    end

    assert_response :unprocessable_entity
    assert_select '.alert-error' do
      assert_select 'span', I18n.t('turnstile.errors.login_failed')
    end
  end
end
