# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'search_autocomplete/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'search_autocomplete'
  spec.version     = SearchAutocomplete::VERSION
  spec.authors     = ['Francis Schiavo']
  spec.email       = ['francischiavo@gmail.com']
  spec.homepage    = 'https://github.com/francis-schiavo/search_autocomplete'
  spec.summary     = 'This gem adds autocomplete and filter functionality to rails apps.'
  spec.description = 'Search and autocomplete based on Arel and WebComponents.'
  spec.license     = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
end
