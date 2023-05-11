# -*- encoding: utf-8 -*-
# stub: raabro 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "raabro".freeze
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Mettraux".freeze]
  s.date = "2020-10-05"
  s.description = "A very dumb PEG parser library, with a horrible interface.".freeze
  s.email = ["jmettraux+flor@gmail.com".freeze]
  s.homepage = "https://github.com/floraison/raabro".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "a very dumb PEG parser library".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
  end
end
