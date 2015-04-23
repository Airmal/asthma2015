require "test_helper"

describe UserPoint do
  let(:user_point) { build(:user_point) }

  it "must be valid" do
    user_point.must_be :valid?
  end

  describe "当用户积分表的乘以系数为0时" do
   it "应该让乘以系数为1" do
    user_point.modulus = 0
    user_point.must_be :valid?
   end
  end
end
