require "test_helper"

describe XcusersController do

  let(:xcuser) { xcusers :one }

  it "gets index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xcusers)
  end

  it "gets new" do
    get :new
    assert_response :success
  end

  it "creates xcuser" do
    assert_difference('Xcuser.count') do
      post :create, xcuser: { address: xcuser.address, company: xcuser.company, email: xcuser.email, name: xcuser.name, office: xcuser.office, phone: xcuser.phone }
    end

    assert_redirected_to xcuser_path(assigns(:xcuser))
  end

  it "shows xcuser" do
    get :show, id: xcuser
    assert_response :success
  end

  it "gets edit" do
    get :edit, id: xcuser
    assert_response :success
  end

  it "updates xcuser" do
    put :update, id: xcuser, xcuser: { address: xcuser.address, company: xcuser.company, email: xcuser.email, name: xcuser.name, office: xcuser.office, phone: xcuser.phone }
    assert_redirected_to xcuser_path(assigns(:xcuser))
  end

  it "destroys xcuser" do
    assert_difference('Xcuser.count', -1) do
      delete :destroy, id: xcuser
    end

    assert_redirected_to xcusers_path
  end

end
