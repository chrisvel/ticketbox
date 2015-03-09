require 'test_helper'

class AssetsAssetlocationsControllerTest < ActionController::TestCase
  setup do
    @asset_location = asset_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_location" do
    assert_difference('AssetsAssetlocation.count') do
      post :create, asset_location: { location: @asset_location.location, owner_id: @asset_location.owner_id }
    end

    assert_redirected_to asset_location_path(assigns(:asset_location))
  end

  test "should show asset_location" do
    get :show, id: @asset_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asset_location
    assert_response :success
  end

  test "should update asset_location" do
    patch :update, id: @asset_location, asset_location: { location: @asset_location.location, owner_id: @asset_location.owner_id }
    assert_redirected_to asset_location_path(assigns(:asset_location))
  end

  test "should destroy asset_location" do
    assert_difference('AssetsAssetlocation.count', -1) do
      delete :destroy, id: @asset_location
    end

    assert_redirected_to asset_locations_path
  end
end
