# -*- encoding: utf-8 -*-
# stub: audited 5.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "audited".freeze
  s.version = "5.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brandon Keepers".freeze, "Kenneth Kalmer".freeze, "Daniel Morrison".freeze, "Brian Ryckbost".freeze, "Steve Richert".freeze, "Ryan Glover".freeze]
  s.date = "2023-02-22"
  s.description = "Log all changes to your models".freeze
  s.email = "info@collectiveidea.com".freeze
  s.homepage = "https://github.com/collectiveidea/audited".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Log all changes to your models".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 5.0", "< 7.1"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 5.0", "< 7.1"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<single_cov>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 1.3.6"])
    s.add_development_dependency(%q<mysql2>.freeze, [">= 0.3.20"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0.18", "< 2.0"])
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 5.0", "< 7.1"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 5.0", "< 7.1"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<single_cov>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 1.3.6"])
    s.add_dependency(%q<mysql2>.freeze, [">= 0.3.20"])
    s.add_dependency(%q<pg>.freeze, [">= 0.18", "< 2.0"])
  end
end
