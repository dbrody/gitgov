class AddActionsCountCaching < ActiveRecord::Migration
  def change

  	add_column :document_elements, :suspicious_count, :integer, :default => 0, :null => false
  	add_column :document_elements, :important_count, :integer, :default => 0, :null => false
  	add_column :document_elements, :fluff_count, :integer, :default => 0, :null => false

  	add_column :documents, :suspicious_count, :integer, :default => 0, :null => false
  	add_column :documents, :important_count, :integer, :default => 0, :null => false
  	add_column :documents, :fluff_count, :integer, :default => 0, :null => false

  end
end
