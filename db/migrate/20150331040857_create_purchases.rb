class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :administrator_id, :comment => '管理员ID'
      t.integer :program_id, :comment => '节目ID'
      t.integer :purchase_flg, :comment => '请购状态'
      t.integer :num_purchase, :comment => '请购数量'

      t.timestamps null: false
    end
  end
end
