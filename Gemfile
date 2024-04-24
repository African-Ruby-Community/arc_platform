# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'active_storage_validations', '~> 1.0' # Active Storage gems for validating attachments https://github.com/igorkasyanchuk/active_storage_validations
gem 'aws-sdk-s3', '~> 1.119', require: false # Official AWS Ruby gem for Amazon S3
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'cancancan', '~> 3.4' # Authorization library which restricts what resources a given user is allowed to access
gem 'cssbundling-rails' # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'devise' # Devise 4.0 works with Rails 4.1 onwards.
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'
gem 'jbuilder' # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jsbundling-rails' # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'mini_magick', '~> 4.12'
gem 'pg', '~> 1.1' # Use postgresql as the database for Active Record
gem 'premailer-rails', '~> 1.12' # This gem is a drop in solution for styling HTML emails with CSS
gem 'puma', '~> 5.0' # Use the Puma web server [https://github.com/puma/puma]
gem 'rails', '~> 7.0.3' # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production
# An ActionMailer adapter to send email using SendGrid's HTTPS Web API (instead of SMTP).
gem 'sendgrid-actionmailer', '~> 3.2'
gem 'simple_form', '~> 5.1' # Gem to pimp up forms
gem 'sitemap_generator' # A dynamic sitemap generator gem for the Ruby on Rails framework
gem 'sprockets-rails' # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'stimulus-rails' # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'turbo-rails' # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# gem "kredis" # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
# gem "sassc-rails" # Use Sass to process CSS

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', '~> 1.51.0', require: false
  gem 'rubocop-performance', '~> 1.18', require: false
  gem 'rubocop-rails', '~> 2.19.1', require: false
end

group :development do
  # Capistrano - deployment gems
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-asdf'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-sidekiq'
  gem 'capistrano-webpacker-precompile', require: false
  gem 'dockerfile-rails', '>= 1.2'
  gem 'letter_opener'
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]

  # gem "rack-mini-profiler" # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "spring" #Speed up commands on slow machines / big apps [https://github.com/rails/spring]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'faker', '~> 3.1'
  gem 'rspec-rails', '~> 6.1'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false  # Code coverage analysis tool for ruby
  gem 'webdrivers'
end

gem 'rails_admin', '~> 3.1'
gem 'sassc-rails'
