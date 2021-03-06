# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/submit_to_beta_app_review/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-submit_to_beta_app_review'
  spec.version       = Fastlane::SubmitToBetaAppReview::VERSION
  spec.author        = 'Dan Loewenherz'
  spec.email         = 'dan@lionheartsw.com'

  spec.summary       = 'Submits an already processed build to Beta App Review.'
  spec.homepage      = "https://github.com/lionheart/fastlane-plugin-submit_to_beta_app_review"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'fastlane', '>= 2.59.0'
end
