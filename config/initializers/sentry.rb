# frozen_string_literal: true

# Sentry configuration for Rails 8
# Docs: https://docs.sentry.io/platforms/ruby/guides/rails/

sentry_dsn = Rails.application.credentials.dig(:sentry, :dsn)
sentry_enabled = Rails.application.credentials.dig(:sentry, :enabled) != false

if sentry_dsn && !sentry_dsn.empty? && sentry_enabled
  Sentry.init do |config|
    config.dsn = sentry_dsn
    config.environment = Rails.env
    config.enabled_environments = %w[production test development]
    
    # Release tracking
    config.release = begin
      `git rev-parse HEAD 2>/dev/null`.strip.presence || "unknown"
    rescue => e
      Rails.logger.warn("Failed to get git revision: #{e.message}")
      "unknown"
    end
    
    # Breadcrumbs and logging
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.sdk_logger = Rails.logger
    
    # PII and data collection
    config.send_default_pii = Rails.env.development?
    
    # Performance monitoring - environment specific
    traces_rate = Rails.application.credentials.dig(:sentry, :traces_sample_rate) || 
                  (Rails.env.production? ? 0.1 : 1.0)
    profiles_rate = Rails.application.credentials.dig(:sentry, :profiles_sample_rate) || 
                    (Rails.env.production? ? 0.1 : 1.0)
    
    config.traces_sample_rate = traces_rate
    config.profiles_sample_rate = profiles_rate
    
    # Enhanced performance sampling
    config.traces_sampler = lambda do |sampling_context|
      transaction_name = sampling_context[:transaction_context][:name]
      case transaction_name
      when /health|heartbeat|ping/
        0.0  # Skip health checks
      when /users\/(sign_in|sign_up|password)/
        1.0  # Always trace authentication endpoints
      when /projects|chapters|countries/
        0.8  # High sampling for core content
      when /admin/
        0.5  # Sample admin pages at 50%
      else
        traces_rate
      end
    end
    
    # Rails 8 specific instrumentation
    config.rails.report_rescued_exceptions = true
    config.instrumenter = :active_support
    
    # Filter noise - common Rails exceptions
    config.excluded_exceptions += %w[
      ActionController::RoutingError
      ActiveRecord::RecordNotFound
      ActionController::InvalidAuthenticityToken
      ActionController::UnknownFormat
      ActionDispatch::Http::MimeNegotiation::InvalidType
      Rack::QueryParser::ParameterTypeError
      Rack::QueryParser::InvalidParameterError
    ]
    
    # Transaction filtering
    config.before_send_transaction = lambda do |event, hint|
      # Skip asset requests and health checks
      return nil if event.transaction&.match?(/\.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$/)
      return nil if event.transaction&.match?(/health|assets|favicon|robots\.txt/)
      event
    end
    
    # Enhanced error context and filtering
    config.before_send = lambda do |event, hint|
      # Skip letter opener and development tools
      return nil if event.request&.url&.match?(/letter_opener|web-console|__better_errors/)
      
      # Add user context (non-PII)
      if defined?(Current) && Current.respond_to?(:user) && Current.user
        event.user = {
          id: Current.user.id,
          role: Current.user.role,
          created_at: Current.user.created_at
        }
      end
      
      # Add request context
      if event.request
        event.tags.merge!({
          request_id: event.request.env['action_dispatch.request_id'],
          user_agent: event.request.env['HTTP_USER_AGENT']&.truncate(100),
          referer: event.request.env['HTTP_REFERER']&.truncate(200)
        })
      end
      
      # Add Rails context
      event.tags.merge!({
        rails_version: Rails.version,
        ruby_version: RUBY_VERSION,
        environment: Rails.env
      })
      
      # Scrub sensitive data
      if event.request&.data.is_a?(String)
        event.request.data = event.request.data
          .gsub(/password=[^&]+/i, 'password=[FILTERED]')
          .gsub(/token=[^&]+/i, 'token=[FILTERED]')
          .gsub(/api_key=[^&]+/i, 'api_key=[FILTERED]')
          .gsub(/secret=[^&]+/i, 'secret=[FILTERED]')
      end
      
      event
    end
    
    # Test environment configuration
    if Rails.env.test?
      config.transport.transport_class = Sentry::DummyTransport
      config.background_worker_threads = 0
    end
    
    # Production optimizations
    if Rails.env.production?
      config.background_worker_threads = 5
      config.send_client_reports = true
    end
  end
  
  Rails.logger.info "Sentry initialized for #{Rails.env} environment"
else
  Rails.logger.warn "Sentry not initialized - DSN missing or disabled"
end
