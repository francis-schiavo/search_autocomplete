# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'search_autocomplete/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.7.2'
  spec.name        = 'search_autocomplete'
  spec.version     = SearchAutocomplete::VERSION
  spec.authors     = ['Francis Schiavo']
  spec.email       = ['francischiavo@gmail.com']
  spec.homepage    = 'https://github.com/francis-schiavo/search_autocomplete'
  spec.summary     = 'This gem adds autocomplete and filter functionality to rails apps.'
  spec.description = 'Search and autocomplete based on Arel and WebComponents.'
  spec.license     = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/francis-schiavo/search_autocomplete'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/francis-schiavo/search_autocomplete/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/francis-schiavo/search_autocomplete/blob/master/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/search_autocomplete'

  spec.add_development_dependency 'rails', '~> 6.0.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rails'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
end
