class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
      t.string :name
      t.string :route
      t.belongs_to :owner, class_name: "Office"
      t.boolean :erased, default: false

      t.timestamps
    end
  end
end
