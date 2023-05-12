# -*- encoding: utf-8 -*-
# stub: capistrano-webpacker-precompile 0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano-webpacker-precompile".freeze
  s.version = "0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dmitriy Beliaev".freeze]
  s.date = "2018-07-02"
  s.description = "Oftenly local dev machine is much more powerfull than the remote one (VPS, for example).\n  Every deploy system need to recompile all the assets in packs folder (by default). \n  If the project is large, it'll take to much time and remote machine processor load that it would be much more easier to precompile assets on local machine.".freeze
  s.email = ["admin@cogear.ru".freeze]
  s.homepage = "https://github.com/codemotion/capistrano-webpacker-precompile".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "This gem is crafted to make webpacker users life easier.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<capistrano>.freeze, ["~> 3.1"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<capistrano>.freeze, ["~> 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
