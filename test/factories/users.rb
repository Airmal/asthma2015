FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:mobile){ |n| "1360000000#{n}" }
    sequence(:email) { |n| "mail#{n}@yunmed.net" }
    sequence(:real_name) { |n| "name#{n}" }
    gender '男'
    date_of_birth '19800101'.to_date
    city_id 1
    location_id 1
    hospital_id 1
    department_id 1
    password 'p@ssw0rd'
    password_confirmation 'p@ssw0rd'
    guest false
    state 1
    verified false
  end

  # 讲者
  factory :speaker, :parent => :user do
    teachable true
  end

  # 提问者
  factory :asker, :parent => :user do

  end

  # 回复者
  factory :replier, :parent => :user do
    
  end

  # 管理员用户
  # factory :admin, :parent => :user do
  #   email Settings.admin_email
  # end

  factory :uploader, :parent => :user do
    uploadable true
  end

  # 屏蔽的用户
  factory :blocked_user, :parent => :user do
    state 2
  end

  # 删除的用户（软删除）
  factory :deleted_user, :parent => :user do
    state -1
  end

end
