class Union
  module Query

    private

    def _make_query
      # I am aware that this is a little bit nasty to debug Thomas, open to modifications :)
      [ 
      _make_selection_clauses
        .join("\n   UNION\n"),
      _make_order_clause,
      _make_limit_clause,
      _make_offset_clause
      ].join
    end

    def _make_limit_clause
      return "" unless @limit
      "   LIMIT #{@limit}\n"
    end

    def _make_offset_clause
      return "" unless @offset
      "   OFFSET #{@offset}\n"
    end

    def _make_order_clause
      return "" unless @order_field
      "   ORDER BY #{@order_field}\n"
    end

    def _make_selection_clauses
      # TODO: Check last table has fields
      # I am aware that this is a little bit nasty to debug Thomas, open to modifications :)
      tables
        .zip(fields)
        .map{ |table_name, fields| _make_selection_clause(table_name, fields) }
    end

    def _make_selection_clause( table_name, fields )
      "SELECT #{fields.join(', ')}, #{@order_field}, '#{table_name}' AS type FROM #{table_name}"
    end
  end
end
