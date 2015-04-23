class CreateInvitates < ActiveRecord::Migration
  def change
    create_table :invitates do |t|
      t.string :invitate_cd, :comment => '邀请码CD'
      t.integer :invitate_flg, default: 0,:comment => '邀请码FLG'
      t.integer :user_id, :comment => '用户ID'
      t.integer :program_id, :comment => '节目ID'
      t.integer :admin_id, :comment => '管理员ID'
      t.datetime :issure_time, :comment => '发放时间'
      t.datetime :use_time, :comment => '使用时间'
      t.string :batch, :comment => '批次'

      t.timestamps null: false
    end
  end
end
