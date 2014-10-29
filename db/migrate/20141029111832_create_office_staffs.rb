class CreateOfficeStaffs < ActiveRecord::Migration
  def change
    create_table :office_staffs do |t|
      t.string :name
      t.references :office
      t.boolean :erased, default: false

      t.timestamps
    end
  end
end
