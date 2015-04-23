class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, :comment => '用户提问记录表' do |t|
      # 提问者（用户 ID）
      t.integer :asker_id, :comment => '提问者（用户 ID）'
      # 节目 ID
      t.integer :program_id, :comment => '节目 ID'
      # 提问标题
      t.string :title, :comment => '提问标题'
      # 提问内容（不限字数，可引入图片）
      t.text :content, :comment => '提问内容（不限字数，可引入图片）'
      # 问题状态
      t.integer :state, :comment => '问题状态'
      # 同问者
      t.text :followers, :comment => '同问者'

      t.timestamps null: false
    end
  end
end
