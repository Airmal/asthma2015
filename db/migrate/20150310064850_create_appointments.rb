class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments, :comment => '节目预约记录表' do |t|
      # 用户 ID
      t.belongs_to :user, :comment => '用户 ID'
      # 节目 ID
      t.belongs_to :program, :comment => '节目 ID'
      # 预约状态
      t.integer :state, :comment => '预约状态'

      t.timestamps null: false
    end
  end
end
