# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'butter_sand/version'

Gem::Specification.new do |spec|
  spec.name          = "butter_sand"
  spec.version       = ButterSand::VERSION
  spec.authors       = ["Shun Sugai"]
  spec.email         = ["sugaishun@gmail.com"]
  spec.description   = "Ruby wrapper for marusei butter sand website"
  spec.summary       = "Ruby wrapper for marusei butter sand website"
  spec.homepage      = "https://github.com/shunsugai/butter_sand"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.8'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'nokogiri', '~> 1.5.6'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'simplecov'
end
