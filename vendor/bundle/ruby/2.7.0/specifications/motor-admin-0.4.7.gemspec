# -*- encoding: utf-8 -*-
# stub: motor-admin 0.4.7 ruby lib

Gem::Specification.new do |s|
  s.name = "motor-admin".freeze
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/motor-admin/motor-admin-rails/issues", "documentation_uri" => "https://github.com/motor-admin/motor-admin-rails/tree/master/guides", "homepage_uri" => "https://www.getmotoradmin.com", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/motor-admin/motor-admin-rails" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pete Matsyburka".freeze]
  s.date = "2023-02-19"
  s.description = "Motor Admin allows to create a flexible admin panel with writing less code.\nAll customizations to the admin panel can be made directly in the UI without\nthe need of writing any configurations code.\n".freeze
  s.email = ["pete@getmotoradmin.com".freeze]
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\n    ==================\n    Run `rails g motor:install && rake db:migrate`\n    to configure and start using Motor Admin\n\n    Run `rails g motor:upgrade && rake db:migrate`\n    to perform data migration and enable the latest features\n    ==================\n  ".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.6".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Low-code Admin panel and Business intelligence".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<ar_lazy_preload>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<audited>.freeze, ["~> 5.0"])
    s.add_runtime_dependency(%q<cancancan>.freeze, ["~> 3.0"])
    s.add_runtime_dependency(%q<fugit>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<rails>.freeze, [">= 5.2"])
  else
    s.add_dependency(%q<ar_lazy_preload>.freeze, ["~> 1.0"])
    s.add_dependency(%q<audited>.freeze, ["~> 5.0"])
    s.add_dependency(%q<cancancan>.freeze, ["~> 3.0"])
    s.add_dependency(%q<fugit>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 5.2"])
  end
end
