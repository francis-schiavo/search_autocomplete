# frozen_string_literal: true

# Inherited from Rails
module ActionView
  # Inherited from Rails
  module Helpers
    # Helper method for form builder
    class FormBuilder
      ##
      # Creates an autocomplete element from form builder
      def autocomplete_field(method, display_value, autocomplete_path, **options)
        options.reverse_merge!(
          'display-value': find_autocomplete_value(display_value),
          value: @object.send(method),
          url: autocomplete_path,
          minlength: 2,
          name: "#{@object_name}[#{method}]"
        )

        autocomplete_options[:autofocus] = options[:autofocus] if options.include? :autofocus
        @template.content_tag(:'auto-complete', nil, options)
      end

      private

      def find_autocomplete_value(display_expression)
        @object.instance_eval(display_expression)
      rescue StandardError
        ''
      end
    end
  end
end
