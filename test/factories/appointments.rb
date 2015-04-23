FactoryGirl.define do
  factory :appointment do
    user
    program
    state Appointment::STATE[:normal]

    # 已取消的预约
    factory :cancelled_appointment do
      state Appointment::STATE[:cancelled]
    end
  end
end
