class CreateActionFluffs < ActiveRecord::Migration
  def change
    create_table :action_fluffs do |t|
      t.integer :user_id, limit: 8
      t.integer :document_element_id, limit: 8

      t.timestamps
    end
    add_index :action_fluffs, :user_id
    add_index :action_fluffs, :document_element_id
    add_index :action_fluffs, [:user_id, :document_element_id], :unique => true
  end
end
