$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "glm_ember/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "glm_ember"
  s.version     = GlmEmber::VERSION
  s.authors     = ["Gin Lane"]
  s.email       = ["scotty@ginlanemedia.com"]

  s.summary     = "Rails Ember plus Teaspoon/QUnit testing"
  s.description = s.summary

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency 'ember-rails'
  s.add_dependency 'sinon-rails'
  s.add_dependency 'rspec-rails'

  s.add_development_dependency "sqlite3"
end
