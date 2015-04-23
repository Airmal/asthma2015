require "test_helper"

describe Question do
  let(:question) { build(:question) }

  it "must be valid" do
    question.must_be :valid?
  end

  let(:reply) { build(:reply) }
  it "一个用户应该只有一个最佳答案，并且最佳答案无法修改" do
    reply_question = reply.question
    reply.best = true
    reply.save

    invalid_reply = reply_question.replies.build(:question_id => reply_question.id, :best => true)
    invalid_reply.must_be :invalid?
  end


  let(:no_title_question) { build(:no_title_question) }
  it "没有标题的提问" do
    no_title_question.must_be :invalid?
  end

  let(:no_content_question) { build(:no_content_question) }
  it "提问内容不应该为空" do
    no_content_question.must_be :invalid?
  end

  # let(:blocked_question) { build(:blocked_question) }
  # it "内容已被屏蔽" do
  # end
end
