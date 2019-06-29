class CreateRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :refunds do |t|
      t.decimal :amount
      t.string :reason

      t.timestamps
    end
  end
end
