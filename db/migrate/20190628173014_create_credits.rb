class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.decimal :amount
      t.string :label

      t.timestamps
    end
  end
end
