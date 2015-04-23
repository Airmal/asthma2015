class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs, :comment => '节目表' do |t|
      # 节目编号
      t.string :public_no, :comment => '节目编号'
      # 标题
      t.string :title, :comment => '节目标题'
      # 节目预告
      t.string :preview, :comment => '节目预告'
      # 封面
      t.string :cover, :comment => '封面'
      # 简介
      t.string :intro, :comment => '简介'
      # 播出时间
      t.datetime :online_date, :comment => '播出时间'
      # 下线时间
      t.datetime :offline_date, :comment => '下线时间'
      # 直播还是录播
      t.integer :live_or_replay, limit: 1, :comment => '直播还是录播'
      # 学科分类
      t.text :categories, :comment => '学科分类'
      # 组织机构
      t.string :organization, :comment => '组织机构'
      # 讲者
      t.text :speakers, :comment => '讲者'

      t.timestamps null: false
    end
  end
end
