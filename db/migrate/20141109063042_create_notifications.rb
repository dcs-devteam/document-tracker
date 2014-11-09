class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :office
      t.text :body
      t.string :link, default: "#"
      t.integer :role
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
