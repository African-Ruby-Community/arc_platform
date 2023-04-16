source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

#Devise 4.0 works with Rails 4.1 onwards.
gem 'devise'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'
# Official AWS Ruby gem for Amazon S3
gem 'aws-sdk-s3', '~> 1.119', require: false

# Gem to pimp up forms
gem "simple_form", "~> 5.1"

# An ActionMailer adapter to send email using SendGrid's HTTPS Web API (instead of SMTP).
gem 'sendgrid-actionmailer', '~> 3.2'

# This gem is a drop in solution for styling HTML emails with CSS
gem 'premailer-rails', '~> 1.12'

# Authorization library which restricts what resources a given user is allowed to access
gem 'cancancan', '~> 3.4'

# Motor Admin allows you to deploy a no-code admin panel for your application in less than a minute
gem 'motor-admin', '~> 0.4.7'

# Active Storage gems for validating attachments https://github.com/igorkasyanchuk/active_storage_validations
gem 'active_storage_validations', '~> 1.0'
gem 'mini_magick', '~> 4.12'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem "dockerfile-rails", ">= 1.2", :group => :development

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'letter_opener'

  # Capistrano - deployment gems
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-asdf'
  gem 'capistrano-sidekiq'
  gem 'capistrano-webpacker-precompile', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'faker', '~> 3.1'

  # Code coverage analysis tool for ruby
  gem 'simplecov', require: false
end
