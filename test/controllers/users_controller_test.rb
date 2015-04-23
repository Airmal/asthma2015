require "test_helper"

describe UsersController do
  it "should get dashboard" do
    get :dashboard
    assert_response :success
  end

end
