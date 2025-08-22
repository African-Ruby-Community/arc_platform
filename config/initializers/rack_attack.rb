# frozen_string_literal: true

# Configuration for rack-attack to prevent spam and brute force attacks
class Rack::Attack
  ### Configure Cache ###
  # Use Redis as the cache store for rack-attack
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new

  ### Throttle Spammy Clients ###
  # Throttle all requests by IP (60 requests per minute)
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  ### Prevent Brute-Force Login Attacks ###
  # Throttle POST requests to /users/sign_in by IP address
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      req.ip
    end
  end

  # Throttle POST requests to /users/sign_in by email param
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/email:#{normalized_email}"
  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      # Normalize the email, using the same logic as your authentication
      req.params['user'].to_s.downcase.gsub(/\s+/, '') if req.params['user']
    end
  end

  ### Prevent Registration Spam ###
  # Throttle POST requests to /users by IP address
  throttle('registrations/ip', limit: 3, period: 1.hour) do |req|
    if req.path == '/users' && req.post?
      req.ip
    end
  end

  ### Prevent Password Reset Spam ###
  # Throttle POST requests to /users/password by IP
  throttle('password_resets/ip', limit: 5, period: 20.minutes) do |req|
    if req.path == '/users/password' && req.post?
      req.ip
    end
  end

  ### Custom Blocklist ###
  # Block suspicious requests for '/etc/password' or wordpress specific paths.
  blocklist('fail2ban pentesters') do |req|
    # Block suspicious requests
    req.path.include?('/etc/password') ||
    req.path.include?('wp-admin') ||
    req.path.include?('wp-login')
  end

  ### Custom Throttle Response ###
  self.throttled_responder = lambda do |env|
    [ 429,  # status
      { 'Content-Type' => 'text/html' },
      ["<html><body><h1>Too many requests</h1><p>Please try again later.</p></body></html>"]
    ]
  end
end