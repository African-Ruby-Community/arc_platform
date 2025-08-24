# frozen_string_literal: true

require 'net/http'
require 'json'

class TurnstileVerifier
  VERIFY_URI = URI('https://challenges.cloudflare.com/turnstile/v0/siteverify').freeze
  MAX_RETRIES = 3

  attr_reader :token, :ip

  def initialize(token, ip)
    @token = token
    @ip = ip
  end

  def verify
    return false if token.blank?

    if dev_or_test_env?
      log_test_key_warnings

      # If using FAIL sitekey but not the matching FAIL secret, force failure
      if site_key_type == :fail && secret_key_type != :fail
        Rails.logger.error('Turnstile: Test keys mismatch (sitekey/secret). Rejecting verification.')
        return false
      end
    end

    attempt_verification
  end

  private

  def attempt_verification # rubocop:disable Naming/PredicateMethod
    MAX_RETRIES.times do |attempt|
      return true if successful?(attempt)

      sleep(backoff_time(attempt)) if attempt < MAX_RETRIES - 1
    end
    false
  end

  def successful?(attempt)
    response = send_request
    return true if response['success']

    Rails.logger.warn(I18n.t('turnstile.warnings.verification_failed', errors: response['error-codes'].inspect))
    false
  rescue StandardError => e
    Rails.logger.error(I18n.t('turnstile.warnings.verification_error', attempt: attempt + 1, max: MAX_RETRIES,
                                                                       error: e.message))
    false
  end

  def backoff_time(attempt)
    2**attempt
  end

  def send_request
    response = Net::HTTP.post_form(
      VERIFY_URI,
      {
        secret: secret_key,
        response: token,
        remoteip: ip
      }
    )
    JSON.parse(response.body)
  end

  def secret_key
    key = Rails.application.credentials.dig(:cloudflare_turnstile, :secret_key)
    raise 'Turnstile secret key is not configured' if key.blank?

    key
  end

  def site_key
    Rails.application.credentials.dig(:cloudflare_turnstile, :site_key)
  end

  def dev_or_test_env?
    Rails.env.local?
  end

  def key_type_for(key)
    return :unknown if key.nil?
    return :pass if key.start_with?('1x')
    return :fail if key.start_with?('2x')

    :real
  end

  def secret_key_type
    @secret_key_type ||= key_type_for(secret_key)
  end

  def site_key_type
    @site_key_type ||= key_type_for(site_key)
  end

  def log_test_key_warnings
    Rails.logger.warn(I18n.t('turnstile.warnings.pass')) if secret_key_type == :pass
    Rails.logger.warn(I18n.t('turnstile.warnings.fail_mismatch')) if site_key_type == :fail && secret_key_type != :fail
  end
end
