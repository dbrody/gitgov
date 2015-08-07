class AddSubtitleToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :subtitle, :string, :default => '', :null => false
  end
end
