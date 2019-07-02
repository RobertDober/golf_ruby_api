class CreateResourceTagMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_tag_memberships do |t|
      t.resource :references
      t.tag :references

      t.timestamps
    end
  end
end
