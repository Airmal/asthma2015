class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, :comment => '用户短评表' do |t|
      # 用户 ID
      t.integer :user_id, :comment => '用户 ID'
      # 节目 ID
      t.integer :program_id, :comment => '节目 ID'
      # 短评内容（不超过140个字）
      t.string :content, :comment => '短评内容（不超过140个字）'
      # 节目评级（五星评级）
      t.integer :rank, :comment => '节目评级（五星评级）'
      # 短评状态
      t.integer :state, :comment => '短评状态'

      t.timestamps null: false
    end
  end
end
