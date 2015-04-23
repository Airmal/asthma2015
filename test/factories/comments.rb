FactoryGirl.define do
  factory :comment do
    user
    program
    sequence(:content){ |n| "This is Comment#{n}." }
    rank 1
    state Comment::STATE[:normal]

    # 五星评分的短评
    factory :high_rank_comment do
      rank 5
    end

    # # 没有内容的短评
    # factory :no_content_comment do
    #   content ''
    # end

    # 被屏蔽的短评
    factory :blocked_comment do
      state Comment::STATE[:blocked]
    end
  end
end
