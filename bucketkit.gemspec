# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bucketkit/version'

Gem::Specification.new do |spec|
  spec.name          = 'bucketkit'
  spec.version       = Bucketkit::VERSION
  spec.authors       = ['Xystushi']
  spec.email         = ['xystushi@gmail.com']
  spec.summary       = %q{A BitBucket REST API client.}
  spec.homepage      = 'https://github.com/xystushi/bucketkit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_dependency 'sawyer', '~> 0.5', '>= 0.5.4'
  spec.add_dependency 'faraday_middleware', '~> 0.9', '>= 0.9.1'
end
