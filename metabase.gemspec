# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metabase/version'

Gem::Specification.new do |spec|
  spec.name          = 'metabase'
  spec.version       = Metabase::VERSION
  spec.authors       = ['Hiroshi Shimoju']
  spec.email         = ['hiroshi.shimoju@gmail.com']

  spec.summary       = 'Ruby client library for Metabase API'
  spec.description   = 'Ruby client library for Metabase API'
  spec.homepage      = 'https://github.com/shimoju/metabase-ruby'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_runtime_dependency 'faraday', '>= 1.2.0'
  # spec.add_runtime_dependency 'faraday_middleware'
end
