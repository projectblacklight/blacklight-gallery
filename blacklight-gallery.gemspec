# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blacklight/gallery/version'

Gem::Specification.new do |spec|
  spec.name          = "blacklight-gallery"
  spec.version       = Blacklight::Gallery::VERSION
  spec.authors       = ["Chris Beer"]
  spec.email         = ["cabeer@stanford.edu"]
  spec.summary       = %q{Gallery display for Blacklight}
  spec.homepage      = ""
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "blacklight", "5.0.0.pre2"
  spec.add_dependency "bootstrap-sass", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "jettywrapper"
  spec.add_development_dependency "engine_cart"
  spec.add_development_dependency "capybara"
end
