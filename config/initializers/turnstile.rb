RailsCloudflareTurnstile.configure do |c|
  c.site_key = Rails.application.credentials.cloudflare_turnstile[:site_key]
  c.secret_key = Rails.application.credentials.cloudflare_turnstile[:secret_key]
  c.fail_open = false
end
