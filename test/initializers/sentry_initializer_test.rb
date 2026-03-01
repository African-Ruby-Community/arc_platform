# frozen_string_literal: true

require 'test_helper'

class SentryInitializerTest < ActiveSupport::TestCase
  def with_credentials(hash)
    fake_credentials = Object.new
    fake_credentials.define_singleton_method(:dig) do |*keys|
      hash.dig(*keys)
    end

    Rails.application.stubs(:credentials).returns(fake_credentials)
    yield
  ensure
    Rails.application.unstub(:credentials)
  end

  def reload_sentry_initializer
    # Reset Sentry state before reloading initializer
    begin
      Sentry.close
    rescue StandardError
      # ignore if not initialized
    end
    # Reset configuration (be robust even if attr_writer isn't available)
    if Sentry.respond_to?(:configuration=)
      Sentry.configuration = Sentry::Configuration.new
    else
      Sentry.instance_variable_set(:@configuration, Sentry::Configuration.new)
    end

    load Rails.root.join('config/initializers/sentry.rb')
  end

  test 'does not initialize Sentry when credentials[:sentry][:dsn] is absent' do
    with_credentials({}) do
      reload_sentry_initializer
      assert_equal false, Sentry.initialized?, 'Sentry should not initialize without DSN'
    end
  end

  test 'does not initialize Sentry when enabled is false' do
    with_credentials({ sentry: { dsn: 'https://public@example.com/1', enabled: false } }) do
      reload_sentry_initializer
      assert_equal false, Sentry.initialized?, 'Sentry should not initialize when disabled'
    end
  end

  test 'initializes Sentry when credentials[:sentry][:dsn] is present and uses DummyTransport in test env' do
    with_credentials({ sentry: { dsn: 'https://public@example.com/1', enabled: true } }) do
      reload_sentry_initializer
      assert_equal true, Sentry.initialized?, 'Sentry should initialize with DSN'
      assert_includes Sentry.configuration.enabled_environments, 'test'
      assert_includes Sentry.configuration.enabled_environments, 'production'
      assert_includes Sentry.configuration.enabled_environments, 'development'

      client = Sentry.get_current_client
      assert_not_nil client, 'Sentry client should be present after initialization'
      transport = client.transport
      assert_instance_of Sentry::DummyTransport, transport, 'Transport should be DummyTransport in test'

      # Test Rails 8 specific configuration
      assert_equal true, Sentry.configuration.rails.report_rescued_exceptions
      assert_equal :sentry, Sentry.configuration.instrumenter
      assert_equal 0, Sentry.configuration.background_worker_threads
    end
  end

  test 'configures performance monitoring with custom rates' do
    with_credentials({
                       sentry: {
                         dsn: 'https://public@example.com/1',
                         traces_sample_rate: 0.5,
                         profiles_sample_rate: 0.3
                       }
                     }) do
      reload_sentry_initializer
      assert_equal 0.5, Sentry.configuration.traces_sample_rate
      assert_equal 0.3, Sentry.configuration.profiles_sample_rate
    end
  end
end
