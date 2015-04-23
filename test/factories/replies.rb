FactoryGirl.define do
  factory :reply do
    replier
    question
    sequence(:content){ |n| "Reply Content #{n}." }
    best false
  end

end
