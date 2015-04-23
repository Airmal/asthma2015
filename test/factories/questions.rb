FactoryGirl.define do
  factory :question do
    asker
    program
    sequence(:title){ |n| "Question Title #{n}" }
    sequence(:content){ |n| "Content #{n}" }
    state Question::STATE[:normal]
    followers [1]

    # 没有标题的提问
    factory :no_title_question do
      title ''
    end

    # 没有内容的提问
    factory :no_content_question do
      content ''
    end

    # 被屏蔽的短评
    factory :blocked_question do
      state Question::STATE[:blocked]
    end
  end

end
