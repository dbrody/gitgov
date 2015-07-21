class CreateDocumentElements < ActiveRecord::Migration
  def change
    create_table :document_elements do |t|
      t.integer :document_id, limit: 8
      t.string :type
      t.integer :parent_id, limit: 8
      t.integer :position
      t.string :numeral
      t.text :body

      t.timestamps
    end
    add_index :document_elements, :document_id
    add_index :document_elements, :parent_id
    # add_foreign_key :document_elements, :documents # TODO: update to rails ~4.2.1 so we have this method
  end
end
