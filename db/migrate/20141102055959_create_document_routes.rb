class CreateDocumentRoutes < ActiveRecord::Migration
  def change
    create_table :document_routes do |t|
      t.references :document
      t.references :office
      t.datetime :date_in
      t.datetime :date_out
      t.integer :status, default: 0
      t.references :next_route

      t.timestamps
    end
  end
end
