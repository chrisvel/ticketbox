require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  setup do
    @asset = assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset" do
    assert_difference('Asset.count') do
      post :create, asset: { brand: @asset.brand, comment: @asset.comment, date_acquired: @asset.date_acquired, location_id: @asset.location_id, owner_id: @asset.owner_id, recycled: @asset.recycled, serial: @asset.serial, type: @asset.type, user_id: @asset.user_id, ware: @asset.ware }
    end

    assert_redirected_to asset_path(assigns(:asset))
  end

  test "should show asset" do
    get :show, id: @asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asset
    assert_response :success
  end

  test "should update asset" do
    patch :update, id: @asset, asset: { brand: @asset.brand, comment: @asset.comment, date_acquired: @asset.date_acquired, location_id: @asset.location_id, owner_id: @asset.owner_id, recycled: @asset.recycled, serial: @asset.serial, type: @asset.type, user_id: @asset.user_id, ware: @asset.ware }
    assert_redirected_to asset_path(assigns(:asset))
  end

  test "should destroy asset" do
    assert_difference('Asset.count', -1) do
      delete :destroy, id: @asset
    end

    assert_redirected_to assets_path
  end
end
