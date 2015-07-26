class AddRootAndDateToDocument < ActiveRecord::Migration
  def change
  	add_column :documents, :root_element, :integer
  	add_column :documents, :date, :string
  end
end
