require "test_helper"

describe Purchase do
  let(:purchase) { Purchase.new }

  it "must be valid" do
    purchase.must_be :valid?
  end
end
