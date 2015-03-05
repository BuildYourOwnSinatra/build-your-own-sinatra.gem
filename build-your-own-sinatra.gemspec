# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'build-your-own-sinatra/version'

Gem::Specification.new do |spec|
  spec.name          = "build-your-own-sinatra"
  spec.version       = BuildYourOwnSinatra::VERSION
  spec.authors       = ["K-2052"]
  spec.email         = ["k@2052.me"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'bson_ext',          '1.11.1'
  spec.add_dependency 'mongo_mapper',      '0.13.1'
  spec.add_dependency 'mm-sluggable',      '0.3.1'
  spec.add_dependency 'omniauth-identity'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '3.1.0'
  spec.add_development_dependency 'rubocop', '0.28.0'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'factory_girl'
end
