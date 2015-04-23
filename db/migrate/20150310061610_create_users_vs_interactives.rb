class CreateUsersVsInteractives < ActiveRecord::Migration
  def change
    create_table :users_vs_interactives, :comment => '用户互动记录表' do |t|
      # 用户 ID
      t.integer :user_id, :comment => '用户 ID'
      # 节目互动 ID
      t.integer :interactive_id, :comment => '节目互动 ID'
      # 选项
      t.text :options, :comment => '用户选择的所有选项'

      t.timestamps null: false
    end
  end
end
