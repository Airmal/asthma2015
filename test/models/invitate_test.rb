require "test_helper"

describe Invitate do
  let(:invitate) { Invitate.new }

  it "must be valid" do
    invitate.must_be :valid?
  end
end
