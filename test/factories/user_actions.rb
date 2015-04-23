FactoryGirl.define do
  factory :user_action do
    sequence(:action_code){ |n| "action_code#{n}" }
    sequence(:action_name){ |n| "action_name#{n}" }
    point 1
    sequence(:desc){ |n| "Desc balabala #{n}" }

    factory :login_action do
      action_code 'UA_LOGIN'
      action_name '用户登录'
      point 2
      desc '用户每日登录 +2分'
    end
  end

end
