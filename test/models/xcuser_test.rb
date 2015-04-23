require "test_helper"

describe Xcuser do
  let(:xcuser) { Xcuser.new }

  it "must be valid" do
    xcuser.must_be :valid?
  end
end
