require "test_helper"

describe UserAction do
  let(:user_action) { UserAction.new }

  it "must be valid" do
    user_action.must_be :valid?
  end
end
