class CreateCoursewares < ActiveRecord::Migration
  def change
    create_table :coursewares, :comment => '节目课件表' do |t|
      # 上传者（用户 ID）
      t.integer :uploader_id, :comment => '上传者（用户 ID）'
      # 课件类型（视频、文档）
      t.integer :type, :comment => '课件类型（视频、文档、远端视频+本地文档）'
      # 课件名称
      t.string :name, :comment => '课件名称'
      # 远端地址
      t.string :remote_url, :comment => '远端地址'
      # 文件路径
      t.string :file_path, :comment => '文件路径'
      # 课件标签
      t.text :tags, :comment => '课件标签'
      # 是否被认证
      t.boolean :verified, default: false, :comment => '是否被认证'
      # 是否可下载
      t.boolean :downloadable, default: false, :comment => '是否可下载'
      # 所需积分
      t.integer :point, :comment => '所需积分'
      # 所属节目
      t.integer :program_id, :comment => '所属节目'
      # 采用远端地址还是本地路径
      t.integer :remote_or_local, :comment => '采用远端地址还是本地路径（1-远端；2-本地；3-同时）'

      t.timestamps null: false
    end
  end
end
