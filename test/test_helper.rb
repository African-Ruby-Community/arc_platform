# frozen_string_literal: true

# Enable SimpleCov for coverage reporting
require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

# Base for all test cases
module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Load all fixtures in test/fixtures/*.yml
    fixtures :all

    # Include Devise test helpers
    include Devise::Test::IntegrationHelpers

    # Shared test password
    TEST_PASSWORD = 'password123'

    # --- Common test helpers ---

    # Create and persist a test user with optional overrides.
    # Skips validations (e.g. github_username) to simplify setup.
    #
    # @param attrs [Hash] attributes to override defaults
    # @return [User] persisted test user
    def create_test_user(attrs = {})
      defaults = {
        email: 'user@example.com',
        password: TEST_PASSWORD,
        name: 'Test User',
        phone_number: '123-456-7890',
        confirmed_at: Time.current # mark user as confirmed
      }
      user = User.new(defaults.merge(attrs))
      user.save!(validate: false)
      user
    end
  end
end

# For integration (request) tests
module ActionDispatch
  class IntegrationTest
    # Stub Turnstile verification
    def with_turnstile(success:)
      TurnstileVerifier.any_instance.stubs(:verify).returns(success)
      yield
    ensure
      # reset after each test so it doesn't leak
      TurnstileVerifier.any_instance.unstub(:verify)
    end
  end
end

# Global mailer host so we don’t repeat in every test
ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
