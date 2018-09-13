# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clippings_pluck/version'

Gem::Specification.new do |spec|
  spec.name          = "clippings_pluck"
  spec.version       = ClippingsPluck::VERSION
  spec.authors       = ["Jack Plane"]
  spec.email         = ["jgplane@gmail.com"]

  spec.summary       = "Kindle Clippings file parser"
  spec.description   = "https://github.com/jgplane/clippings-pluck"
  spec.homepage      = "https://github.com/jgplane/clippings-pluck"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
