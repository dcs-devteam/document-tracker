class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.references :document_type
      t.references :office
      t.string :owner
      t.string :tracking_number
      t.integer :status, default: 0
      t.boolean :erased, default: false

      t.timestamps
    end
  end
end
