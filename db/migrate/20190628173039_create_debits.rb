class CreateDebits < ActiveRecord::Migration[5.2]
  def change
    create_table :debits do |t|
      t.decimal :amount
      t.string :label

      t.timestamps
    end
  end
end
