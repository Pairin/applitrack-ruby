# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'applitrack/version'

Gem::Specification.new do |spec|
  spec.name          = "applitrack"
  spec.version       = Applitrack::VERSION
  spec.authors       = ["Alejandro Vazquez"]
  spec.email         = ["avazquez@pairin.com"]
  spec.summary       = "Gem for accessing Applitrack API"
  spec.homepage      = "https://github.com/Pairin/applitrack-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "> 1.5.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
