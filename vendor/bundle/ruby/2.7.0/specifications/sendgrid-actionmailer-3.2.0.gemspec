# -*- encoding: utf-8 -*-
# stub: sendgrid-actionmailer 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sendgrid-actionmailer".freeze
  s.version = "3.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eddie Zaneski".freeze, "Kristj\u00E1n P\u00E9tursson".freeze, "Nick Muerdter".freeze]
  s.date = "2021-02-16"
  s.description = "Use ActionMailer with SendGrid's Web API.".freeze
  s.email = ["eddiezane@gmail.com".freeze, "kristjan@gmail.com".freeze, "stuff@nickm.org".freeze]
  s.homepage = "https://github.com/eddiezane/sendgrid-actionmailer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "SendGrid support for ActionMailer.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<mail>.freeze, ["~> 2.7"])
    s.add_runtime_dependency(%q<sendgrid-ruby>.freeze, ["~> 6.4"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.1.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.2"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
  else
    s.add_dependency(%q<mail>.freeze, ["~> 2.7"])
    s.add_dependency(%q<sendgrid-ruby>.freeze, ["~> 6.4"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.2"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
