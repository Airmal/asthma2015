class CreateXcusers < ActiveRecord::Migration
  def change
    create_table :xcusers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :company
      t.string :office
      t.string :address

      t.timestamps null: false
    end
  end
end
