class CreateOfficeStaffs < ActiveRecord::Migration
  def change
    create_table :office_staffs do |t|
      t.string :name
      t.references :office
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
