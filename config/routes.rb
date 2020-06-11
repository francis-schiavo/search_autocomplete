# frozen_string_literal: true

SearchAutocomplete::Engine.routes.draw do
  get '/*model_name', to: 'autocomplete#autocomplete', as: 'search'
end
