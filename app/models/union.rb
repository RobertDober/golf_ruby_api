require_relative './union/query'
class Union

  include Query

  InconsistantState = Class.new RuntimeError

  # Represents the following query structure
  #
  # SELECT <f>11, <f>12, .., <f>1n, '<table_name>1' as type FROM <table_name>1
  #    UNION
  # ...
  # SELECT <f>m1, <f>m2, ..., <f>mn, '<table_name>m' FROM <table_name>m
  #    ORDER BY <order_field>
  #    LIMIT <limit>
  #    OFFSET <offset>


  attr_reader :tables # [<table_name>1 ... <table_name>m]
  attr_reader :fields # [ ... [ <f>ij ] ... ]
  attr_reader :limit
  attr_reader :offset
  attr_reader :order_field # fixed to :updated_at for this PoC

  def add_fields *table_fields
    _check_for_table_name! table_fields.flatten
    _check_for_field_count! table_fields.flatten

    fields << table_fields.flatten
    self
  end

  def add_table table_name, *field_names
    @tables << table_name
    add_fields(*field_names) unless field_names.flatten.empty?
    self
  end

  def limit new_limit
    @limit = new_limit
    self
  end

  def offset new_offset
    @offset = new_offset
    self
  end

  # No to_s kludge to run the query inside the console, PLEASE!!!
  def execute
    query = _make_query
    # SQL injection is possible here !!!
    ActiveRecord::Base.connection.execute(query)
  end

  def to_sql
    _make_query
  end

  private

  def initialize
    @order_field = :updated_at
    @field_count = nil

    @limit  = nil
    @offset = nil
    
    @tables = []
    @fields = []
  end
  

  def _check_for_table_name! new_fields
    raise InconsistantState,
      "no new table defined for these fields #{new_fields.inspect}, last table #{tables.last} has already defined its fields\n" +
      "please use `#add_fields` exactly **after** ab `#add_table` without field names!" unless tables.size - 1 == fields.size
  end

  def _check_for_field_count! new_fields
    if fields.empty?
      @field_count = new_fields.size
    elsif new_fields.size != @field_count
      raise InconsistantState,
        "need exactly #{@field_count} fields"
    end
  end

end
