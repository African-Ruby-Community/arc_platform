# -*- encoding: utf-8 -*-
# stub: capistrano-passenger 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-passenger".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Isaac Betesh".freeze]
  s.date = "2021-04-05"
  s.description = "Passenger support for Capistrano 3.x".freeze
  s.email = ["iybetesh@gmail.com".freeze]
  s.homepage = "https://github.com/capistrano/passenger".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "==== Release notes for capistrano-passenger ====\npassenger once had only one way to restart: `touch tmp/restart.txt`\nBeginning with passenger v4.0.33, a new way was introduced: `passenger-config restart-app`\n\nThe new way to restart was not initially practical for everyone,\nsince for versions of passenger prior to v5.0.10,\nit required your deployment user to have sudo access for some server configurations.\n\ncapistrano-passenger gives you the flexibility to choose your restart approach, or to rely on reasonable defaults.\n\nIf you want to restart using `touch tmp/restart.txt`, add this to your config/deploy.rb:\n\n    set :passenger_restart_with_touch, true\n\nIf you want to restart using `passenger-config restart-app`, add this to your config/deploy.rb:\n\n    set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here\n\nIf you don't set `:passenger_restart_with_touch`, capistrano-passenger will check what version of passenger you are running\nand use `passenger-config restart-app` if it is available in that version.\n\nIf you are running passenger in standalone mode, it is possible for you to put passenger in your\nGemfile and rely on capistrano-bundler to install it with the rest of your bundle.\nIf you are installing passenger during your deployment AND you want to restart using `passenger-config restart-app`,\nyou need to set `:passenger_in_gemfile` to `true` in your `config/deploy.rb`.\n================================================\n".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Passenger support for Capistrano 3.x".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capistrano>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<capistrano>.freeze, ["~> 3.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
