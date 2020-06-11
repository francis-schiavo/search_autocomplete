# frozen_string_literal: true

Rails.application.routes.draw do
  mount SearchAutocomplete::Engine => '/search_autocomplete'
end
