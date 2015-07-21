class AddNestedSetToDocumentElement < ActiveRecord::Migration
  def change

    # add_column :document_elements, :parent_id, :integer, limit: 8, :null => true, :index => true
    add_column :document_elements, :lft, :integer, limit: 8, :null => false, :index => true
    add_column :document_elements, :rgt, :integer, limit: 8, :null => false, :index => true

  end
end
