class CreateOfficeMeta < ActiveRecord::Migration
  def change
    create_table :office_meta do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
