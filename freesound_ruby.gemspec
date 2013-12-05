# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freesound/version'

Gem::Specification.new do |spec|
  spec.name          = "freesound_ruby"
  spec.version       = Freesound::VERSION
  spec.authors       = ["Alex Genco"]
  spec.email         = ["alexgenco@gmail.com"]
  spec.summary       = "A Ruby library for consuming the Freesound.org API"
  spec.homepage      = "https://github.com/alexgenco/freesound_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activeresource", "~> 4.0.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock", "~> 1.8.0"
  spec.add_development_dependency "vcr",     "~> 2.8.0"
end
