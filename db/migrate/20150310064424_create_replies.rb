class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, :comment => '用户回复记录表' do |t|
      # 回复者（用户 ID）
      t.integer :replier_id, :comment => '回复者（用户 ID）'
      # 问题 ID
      t.integer :question_id, :comment => '问题 ID'
      # 回复内容
      t.text :content, :comment => '回复内容'
      # 是否最佳
      t.boolean :best, default: false, :comment => '是否最佳'
      # 状态
      t.integer :state, :comment => '状态'

      t.timestamps null: false
    end
  end
end
