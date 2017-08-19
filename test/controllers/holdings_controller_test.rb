require 'test_helper'

class HoldingsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:one)
    @holding = holdings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:holdings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create holding" do
    assert_difference('Holding.count') do
      post :create, holding: {symbol: @holding.symbol, quantity: @holding.quantity, avg_price: @holding.avg_price}
    end

    assert_redirected_to modules_path()
  end

  test "should show holding" do
    get :show, id: @holding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @holding
    assert_response :success
  end

  test "should update holding" do
    patch :update, id: @holding, holding: {quantity: 200}
    assert_redirected_to holding_path(assigns(:holding))
  end

  test "should destroy holding" do
    assert_difference('Holding.count', -1) do
      delete :destroy, id: @holding
    end

    assert_redirected_to holdings_path
  end
end
