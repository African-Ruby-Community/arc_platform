# -*- encoding: utf-8 -*-
# stub: active_storage_validations 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "active_storage_validations".freeze
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Kasyanchuk".freeze]
  s.date = "2022-10-28"
  s.description = "Validations for Active Storage (presence)".freeze
  s.email = ["igorkasyanchuk@gmail.com".freeze]
  s.homepage = "https://github.com/igorkasyanchuk/active_storage_validations".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Validations for Active Storage".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activejob>.freeze, [">= 5.2.0"])
    s.add_runtime_dependency(%q<activemodel>.freeze, [">= 5.2.0"])
    s.add_runtime_dependency(%q<activestorage>.freeze, [">= 5.2.0"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.2.0"])
    s.add_development_dependency(%q<combustion>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
    s.add_development_dependency(%q<ruby-vips>.freeze, [">= 2.1.0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_development_dependency(%q<marcel>.freeze, [">= 0"])
    s.add_development_dependency(%q<globalid>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activejob>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<activemodel>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<activestorage>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.2.0"])
    s.add_dependency(%q<combustion>.freeze, ["~> 1.3"])
    s.add_dependency(%q<mini_magick>.freeze, [">= 4.9.5"])
    s.add_dependency(%q<ruby-vips>.freeze, [">= 2.1.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<marcel>.freeze, [">= 0"])
    s.add_dependency(%q<globalid>.freeze, [">= 0"])
  end
end
