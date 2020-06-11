# frozen_string_literal: true

module SearchAutocomplete
  # Autocomplete
  class AutocompleteController < ActionController::Base
    before_action :find_model, only: :autocomplete

    ##
    # Main autocomplete action
    def autocomplete
      data = autocomplete_search
      render json: data.map { |item| { id: item.id, label: label(item), value: value(item) } }
    end

    private

    def autocomplete_search
      arel_table = @model.arel_table
      node = Arel::Nodes::SqlLiteral.new "'%#{params[:term]}%'"

      search_field = @model.autocomplete_options[:search_field]
      # Assume postgres jsonb
      if search_field.is_a? Array
        op = Arel::Nodes::InfixOperation.new('->>', arel_table[search_field[0]], Arel::Nodes.build_quoted(search_field[1]))
        query_builder = params[:term] ? @model.where(op.matches(node)) : @model
      else
        query_builder = params[:term] ? @model.where(arel_table[search_field].matches(node)) : @model
      end

      @model.autocomplete_options[:filters].each do |filter|
        next unless params[filter.to_s].present?

        query_builder = query_builder.where(arel_table[filter].eq(params[filter.to_s]))
      end
      query_builder.limit(SearchAutocomplete.autocomplete_size)
    end

    def label(item)
      values = @model.autocomplete_options[:display_fields].map do |field|
        if field.is_a? Array
          item.instance_eval(field[0].to_s)[field[1].to_s]
        else
          item.instance_eval(field.to_s)
        end
      end
      values.join ' - '
    end

    def value(item)
      search_field = @model.autocomplete_options[:search_field]
      if search_field.is_a? Array
        item.instance_eval(search_field[0].to_s)[search_field[1].to_s]
      else
        item.instance_eval(search_field.to_s)
      end
    end

    def find_model
      model_name = params[:model_name].sub('/', '::').camelize
      @model = model_name.constantize
    end
  end
end
