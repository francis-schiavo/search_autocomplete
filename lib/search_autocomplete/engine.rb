# frozen_string_literal: true

module SearchAutocomplete
  # Autocomplete engine
  class Engine < ::Rails::Engine
    engine_name 'search_autocomplete'
    isolate_namespace SearchAutocomplete
  end
end
