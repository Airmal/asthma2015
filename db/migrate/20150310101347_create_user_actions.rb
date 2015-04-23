class CreateUserActions < ActiveRecord::Migration
  def change
    create_table :user_actions, :comment => '用户行为积分规则表' do |t|
      # 用户行为代码
      t.string :action_code, :comment => '用户行为代码'
      # 用户行为名称
      t.string :action_name, :comment => '用户行为名称'
      # 积分分值
      t.integer :point, :comment => '积分分值'
      # 备注
      t.string :desc, :comment => '备注'

      t.timestamps null: false
    end
    add_index :user_actions, :action_code, unique: true
  end
end
