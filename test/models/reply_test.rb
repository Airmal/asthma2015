require "test_helper"

describe Reply do
  let(:reply) { Reply.new }

  it "must be valid" do
    reply.must_be :valid?
  end
end
