class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.text :url
      t.string :short_description
      t.string :long_description

      t.timestamps
    end
  end
end
