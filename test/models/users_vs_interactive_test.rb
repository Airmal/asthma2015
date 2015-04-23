require "test_helper"

describe UsersVsInteractive do
  let(:users_vs_interactive) { build(:users_vs_interactive) }

  it "must be valid" do
    users_vs_interactive.must_be :valid?
  end

  describe "用户互动记录表" do

 	it "互动内容表不为多选时，用户选择的所有选项必须是单选" do
      user = users_vs_interactive.user
      interactive = users_vs_interactive.interactive
      interactive.multiple = false
      users_vs_interactive.options = ['A', 'B', 'C', 'D']
      users_vs_interactive.must_be :invalid?
    end
  end
end
