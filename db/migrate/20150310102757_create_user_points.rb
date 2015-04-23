class CreateUserPoints < ActiveRecord::Migration
  def change
    create_table :user_points, :comment => '用户积分表' do |t|
      # 用户 ID
      t.belongs_to :user, :comment => '用户 ID'
      # 用户行为 ID
      t.belongs_to :user_action, :comment => '用户行为 ID'
      # 积分分值
      t.integer :point, :comment => '积分分值'
      # 乘以系数
      t.float :modulus, :comment => '乘以系数'
      # 乘以系数原因
      t.string :modulus_reason, :comment => '乘以系数原因'

      t.timestamps null: false
    end
  end
end
