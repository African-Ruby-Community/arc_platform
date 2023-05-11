
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano-webpacker-precompile/version"

Gem::Specification.new do |spec|
  spec.name          = "capistrano-webpacker-precompile"
  spec.version       = Capistrano::Webpacker::Precompile::VERSION
  spec.authors       = ["Dmitriy Beliaev"]
  spec.email         = ["admin@cogear.ru"]

  spec.summary       = """This gem is crafted to make webpacker users life easier."""
  spec.description   = """Oftenly local dev machine is much more powerfull than the remote one (VPS, for example).
  Every deploy system need to recompile all the assets in packs folder (by default). 
  If the project is large, it'll take to much time and remote machine processor load that it would be much more easier to precompile assets on local machine."""
  spec.homepage      = "https://github.com/codemotion/capistrano-webpacker-precompile"
  spec.license       = "MIT"


  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = `git ls-files`.split("\n")
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'capistrano', '~> 3.1'
  # spec.add_dependency 'capistrano-bundler', '~> 1.1'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end