# config/initializers/invisible_captcha.rb

InvisibleCaptcha.setup do |config|
  # Add more honeypot field names
  config.honeypots           << ['website', 'url', 'phone', 'address', 'comment']
  # config.visual_honeypots    = false
  # Increase the timestamp threshold to 3 seconds (forms submitted faster than this are likely bots)
  config.timestamp_threshold = 3
  config.timestamp_enabled   = true
  config.injectable_styles   = true
  config.spinner_enabled     = true

  # Custom error messages
  config.sentence_for_humans     = 'Please leave this field empty'
  config.timestamp_error_message = 'Sorry, that was too quick! Please wait a moment and try again.'
end
