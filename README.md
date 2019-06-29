
## Example:

```
λ bundle exec pry -r./config/environment.rb                                                                                                              [19:19:00]
[1] pry(main)> u = Union.new.add_table(:debits).add_fields(:amount, :label).add_table(:credits, :amount, :label)
=> #<Union:0x00000000032f8278
 @field_count=2,
 @fields=[[:amount, :label], [:amount, :label]],
 @limit=nil,
 @offset=nil,
 @order_field=:updated_at,
 @tables=[:debits, :credits]>
[2] pry(main)> u.to_sql
=> "SELECT amount, label, updated_at, 'debits' AS type FROM debits\n   UNION\nSELECT amount, label, updated_at, 'credits' AS type FROM credits   ORDER BY updated_at\n"
[3] pry(main)> u.execute
=> #<PG::Result:0x000000000286f8d8 status=PGRES_TUPLES_OK ntuples=6 nfields=4 cmd_tuples=6>
[4] pry(main)> u.execute.to_a
=> [{"amount"=>"42.0", "label"=>"A book from Doug Adams", "updated_at"=>"2019-06-28 17:35:11.690278", "type"=>"debits"},
 {"amount"=>"42.0", "label"=>"Another book from Doug Adams", "updated_at"=>"2019-06-28 17:35:19.234168", "type"=>"debits"},
 {"amount"=>"43.0", "label"=>"A trilogy?", "updated_at"=>"2019-06-28 17:35:32.606284", "type"=>"debits"},
 {"amount"=>"0.01", "label"=>"I earned this, wait I mean self of course", "updated_at"=>"2019-06-28 17:36:01.296329", "type"=>"credits"},
 {"amount"=>"11.0", "label"=>"The numba man", "updated_at"=>"2019-06-28 17:36:14.421669", "type"=>"debits"},
 {"amount"=>"0.02", "label"=>"I truly earned self", "updated_at"=>"2019-06-29 10:18:04.176739", "type"=>"credits"}]
```
