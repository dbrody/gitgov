class CreateActionImportances < ActiveRecord::Migration
  def change
    create_table :action_importances do |t|
      t.integer :user_id, limit: 8
      t.integer :document_element_id, limit: 8

      t.timestamps
    end
    add_index :action_importances, :user_id
    add_index :action_importances, :document_element_id
    add_index :action_importances, [:user_id, :document_element_id], :unique => true
  end
end
