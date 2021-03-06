# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elong/version'

Gem::Specification.new do |spec|
  spec.name          = "elong"
  spec.version       = Elong::VERSION
  spec.authors       = ["icyleaf"]
  spec.email         = ["icyleaf.cn@gmail.com"]
  spec.description   = %q{Elong OpenAPI wrapper}
  spec.summary       = spec.description
  spec.homepage      = "http://github.com/icyleaf/elong"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "rest-client"
  spec.add_dependency 'multi_json'
  spec.add_dependency 'multi_xml'
end
