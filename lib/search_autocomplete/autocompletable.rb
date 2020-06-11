# frozen_string_literal: true

module SearchAutocomplete
  # Autocompletable
  module Autocompletable
    extend ActiveSupport::Concern

    included do
      cattr_accessor :autocomplete_options
      self.autocomplete_options = { configured: false }
    end

    # Autocompletable methods
    module ClassMethods
      ##
      # Configures this model to respond to autocomplete searches
      #
      # @param search_field [String|Array] Name of the main field to perform the search. If an array is given it will search in a jsonb structure.
      # @param display_fields [Array{Symbol}] Array of field names for concatenating as display result
      # @param filters [Array{Symbol}] Array of additional fields to filter
      #
      def autocomplete(search_field, display_fields = [], filters = [])
        self.autocomplete_options = {
          configured: true,
          search_field: search_field,
          display_fields: display_fields.size.zero? ? [search_field] : display_fields,
          filters: filters
        }
      end
    end
  end
end
