# frozen_string_literal: true

# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'my'
  spec.version       = '0.0.1'
  spec.summary       = 'My gem for iamlynnmckay.github.io.'
  spec.description   = 'My gem for iamlynnmckay.github.io.'
  spec.author        = 'Lynn McKay'
  spec.email         = ''
  spec.files         = Dir['lib/**/*.rb', 'bin/**/*', 'site/**/*', 'README.md', 'LICENSE.txt']
  spec.executables   = ['my']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.1.6'

  # Runtime dependencies
  spec.add_dependency 'csv'
  spec.add_dependency 'fileutil'
  spec.add_dependency 'jekyll'
  spec.add_dependency 'liquid'
  spec.add_dependency 'nokogiri'

  # Runtime dependencies for jekyll
  spec.add_dependency 'jekyll-feed'
  spec.add_dependency 'jekyll-seo-tag'
  spec.add_dependency 'jekyll-sitemap'

  # Platform-specific runtime dependencies
  spec.add_dependency 'http_parser.rb'
  spec.add_dependency 'tzinfo'
  spec.add_dependency 'tzinfo-data'
  spec.add_dependency 'wdm' # wdm is used as a development dependency in the consumer however we include it as a runtime dependency so that consumers will access it

  # Development dependencies
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'

  # Test dependencies
  spec.add_development_dependency 'base64'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-jekyll'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'standard'
end
