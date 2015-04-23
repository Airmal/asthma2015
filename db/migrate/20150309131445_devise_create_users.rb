class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :comment => '用户表' do |t|
      ## Database authenticatable
      t.string :username,           null: false, default: "", :comment => '用户名'
      t.string :mobile,             null: false, default: "", :comment => '手机号'
      t.string :email,              null: false, default: "", :comment => '电子邮件'
      t.string :encrypted_password, null: false, default: "", :comment => '用户密码'

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## 用户相关字段
      # 用户真实姓名
      t.string :real_name, :comment => '用户真实姓名'
      # 性别
      t.string :gender, :comment => '性别'
      # 出生日期
      t.date :date_of_birth, :comment => '出生日期'
      # 省市（如北京市、上海市、广东省等）
      t.integer :city_id, :comment => '省市（如北京市、上海市、广东省等）'
      # 地区
      t.integer :location_id, :comment => '地区'
      # 就职医院
      t.integer :hospital_id, :comment => '就职医院'
      # 所在科室
      t.integer :department_id, :comment => '所在科室'
      # 通讯地址
      t.string :contact_address, :comment => '通讯地址'
      # 邮政编码
      t.string :zipcode, :comment => '邮政编码'
      # 擅长医术
      t.string :specialty, :comment => '擅长医术'
      # 头衔
      t.string :title, :comment => '头衔'
      # 医疗教育背景
      t.string :edu_bg, :comment => '医疗教育背景'
      # 简历
      t.string :bio, :comment => '简历'
      # 个性签名
      t.string :signature, :comment => '个性签名'
      # Email 是否公开
      t.boolean :email_public, :comment => 'Email 是否公开'
      # 手机是否公开
      t.boolean :mobile_public, :comment => '手机是否公开'

      # 认证用户
      t.boolean :verified, :default => false, :comment => '认证用户'
      t.integer :state, limit: 1, :default => 1, :comment => '用户状态'
      t.boolean :guest, :default => false, :comment => '是否是游客'
      t.boolean :teachable, :default => false, :comment => '是否能教学'
      t.boolean :uploadable, :default => false, :comment => '是否能上传课件'

      # 评论次数
      t.integer :comments_count, default: 0, :comment => '评论次数'
      # 提问次数
      t.integer :questions_count, default: 0, :comment => '提问次数'
      # 回复次数
      t.integer :replies_count, default: 0, :comment => '回复次数'
      # 收藏的节目
      t.text :favorite_program_ids, :comment => '收藏的节目'
      # 收藏的课程
      t.text :favorite_course_ids, :comment => '收藏的课程'
      # 同问的问题列表
      t.text :followed_question_ids, :comment => '同问的问题列表'
      
      # 时间戳
      t.timestamps
    end

    add_index :users, :username,             unique: true
    add_index :users, :mobile,               unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
