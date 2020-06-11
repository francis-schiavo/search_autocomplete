# frozen_string_literal: true

# Inherited from Rails
module ActionController
  # Searchable
  class Base
    ##
    # Performs a search on the model based on permitted fields
    #
    # @param model [Class] Model to perform the search
    # @param approximate_fields [Array{Symbol}] List of fields to allow as approximate filters
    # @param exact_fields [Array{Symbol}] List of fields to allow as exact filters
    # @param include_list [Array{Symbol}] List of related resources to include
    def search(model, approximate_fields = [], exact_fields = [], include_list = nil)
      arel_table = model.arel_table

      search_conditions = prepare_search_fields arel_table, exact_fields
      search_conditions += prepare_search_fields(arel_table, approximate_fields, false)

      query = include_list.present? ? model.includes(include_list) : model
      query = query.where(*search_conditions) if search_conditions.length.positive?
      query
    end

    private

    def prepare_search_fields(table, fields, exact = true)
      search_conditions = []
      fields.each do |field|
        if field.is_a?(Array)
          search_conditions.push prepare_jsonb_condition(table, field, exact)
        else
          search_conditions.push prepare_simple_condition(table, field, exact)
        end
      end
      search_conditions
    end

    def prepare_simple_condition(table, field, exact)
      return nil unless params.key? field

      if exact
        table[field].eq(params[field])
      else
        table[field].matches(Arel::Nodes::SqlLiteral.new("'%#{params[field]}%'"))
      end
    end

    def prepare_jsonb_condition(table, field, exact)
      field_name = field[0].to_s
      return nil unless params.key? field_name

      condition = Arel::Nodes::InfixOperation.new('->>', table[field_name], Arel::Nodes.build_quoted(field[1]))

      if exact
        condition.eq(params[field_name])
      else
        condition.matches(Arel::Nodes::SqlLiteral.new("'%#{params[field_name]}%'"))
      end
    end
  end
end
