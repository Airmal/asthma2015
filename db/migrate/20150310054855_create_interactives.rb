class CreateInteractives < ActiveRecord::Migration
  def change
    create_table :interactives, :comment => '节目互动内容表' do |t|
      # 互动类型（问答、投票等）
      t.integer :type, :comment => '互动类型（问答、投票等）'
      # 题目
      t.string :title, :comment => '题目'
      # 选项
      t.text :selections, :comment => '选项'
      # 正确答案
      t.string :answer, :comment => '正确答案'
      # 是否多选
      t.boolean :multiple, :comment => '是否多选'
      # 所属节目
      t.integer :program_id, :comment => '所属节目'

      t.timestamps null: false
    end
  end
end
