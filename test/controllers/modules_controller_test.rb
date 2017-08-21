require 'test_helper'

class ModulesControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:one)
  end
  # test "the truth" do
  #   assert true
  # end
  
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should show portfolios" do
    get :portfolios
    assert_response :success
    assert_not_nil assigns(:portfolios)
  end

  
end
