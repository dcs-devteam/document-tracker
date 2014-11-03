class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :office
      t.references :document
      t.text :body
      t.integer :user_role, default: 0
      t.boolean :erased, default: false

      t.timestamps
    end
  end
end
