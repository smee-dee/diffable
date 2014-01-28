# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diffable/version'

Gem::Specification.new do |spec|
  spec.name          = "diffable"
  spec.version       = Diffable::VERSION
  spec.authors       = ["Stefan Schmidt"]
  spec.email         = ['schmiddi@me.com']
  spec.description   = %q{a tool to provide comparison of active record fields}
  spec.summary       = %q{a tool to provide comparison of active record fields}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3"

  spec.add_dependency("i18n")
  spec.add_dependency("activesupport")
  spec.add_dependency("activerecord")
end
