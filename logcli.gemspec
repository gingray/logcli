
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "logcli/version"

Gem::Specification.new do |spec|
  spec.name          = "logcli"
  spec.version       = Logcli::VERSION
  spec.authors       = ["gingray"]
  spec.email         = ["gingray.dev@gmail.com"]

  spec.summary       = %q{log fetcher and remote retriveve files}
  spec.description   = %q{CLI utility for helping works with logs}
  spec.homepage      = "https://github.com/gingray/logcli"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'net-ssh', '~> 5.0.2', '>= 5.0.2'
  spec.add_runtime_dependency 'net-scp', '~> 1.2.1', '>= 1.2.1'
  spec.add_runtime_dependency 'thor', '~> 0.20.3'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
