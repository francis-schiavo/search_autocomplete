# frozen_string_literal: true

require 'search_autocomplete/engine'
require 'search_autocomplete/options'

# Provides an easy way to add autocomplete and filters to rails apps
module SearchAutocomplete
  extend SearchAutocomplete::Options
end

require 'search_autocomplete/autocompletable'
require 'search_autocomplete/searchable'
require 'search_autocomplete/form_builder_helper'

::ActiveRecord::Base.include SearchAutocomplete::Autocompletable
