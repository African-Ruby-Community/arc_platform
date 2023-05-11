# -*- encoding: utf-8 -*-
# stub: ar_lazy_preload 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ar_lazy_preload".freeze
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["DmitryTsepelev".freeze]
  s.date = "2022-12-05"
  s.description = "lazy_preload implementation for ActiveRecord models".freeze
  s.email = ["dmitry.a.tsepelev@gmail.com".freeze]
  s.homepage = "https://github.com/DmitryTsepelev/ar_lazy_preload".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "lazy_preload implementation for ActiveRecord models".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rails>.freeze, [">= 5.2"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 0.81.0"])
    s.add_development_dependency(%q<db-query-matchers>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
    s.add_development_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_development_dependency(%q<memory_profiler>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rails>.freeze, [">= 5.2"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.81.0"])
    s.add_dependency(%q<db-query-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<memory_profiler>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
