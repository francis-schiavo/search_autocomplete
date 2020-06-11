# frozen_string_literal: true

module SearchAutocomplete
  # Configuration module
  module Options
    mattr_accessor :autocomplete_size

    def configure
      yield self
    end
  end
end
