require 'test_helper'

class AssetsBusinessesControllerTest < ActionController::TestCase
  setup do
    @assets_business = assets_businesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assets_businesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assets_business" do
    assert_difference('AssetsBusiness.count') do
      post :create, assets_business: { name: @assets_business.name, owner_id: @assets_business.owner_id }
    end

    assert_redirected_to assets_business_path(assigns(:assets_business))
  end

  test "should show assets_business" do
    get :show, id: @assets_business
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assets_business
    assert_response :success
  end

  test "should update assets_business" do
    patch :update, id: @assets_business, assets_business: { name: @assets_business.name, owner_id: @assets_business.owner_id }
    assert_redirected_to assets_business_path(assigns(:assets_business))
  end

  test "should destroy assets_business" do
    assert_difference('AssetsBusiness.count', -1) do
      delete :destroy, id: @assets_business
    end

    assert_redirected_to assets_businesses_path
  end
end
