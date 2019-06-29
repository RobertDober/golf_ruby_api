class CreateTrans < ActiveRecord::Migration[5.2]
  def change
    create_table :trans do |t|
      t.references :transable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
