FactoryGirl.define do
  factory :user_point do
    user
    user_action
    point 1
    modulus 1.5
    sequence(:modulus_reason){ |n| "Modulus Reason #{n}" }
  end

end
