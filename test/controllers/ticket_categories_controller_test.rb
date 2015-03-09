require 'test_helper'

class AssetsTicketcategoriesControllerTest < ActionController::TestCase
  setup do
    @ticketcategory = ticketcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticketcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticketcategory" do
    assert_difference('AssetsTicketcategory.count') do
      post :create, ticketcategory: { category: @ticketcategory.category, owner_id: @ticketcategory.owner_id }
    end

    assert_redirected_to ticketcategory_path(assigns(:ticketcategory))
  end

  test "should show ticketcategory" do
    get :show, id: @ticketcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticketcategory
    assert_response :success
  end

  test "should update ticketcategory" do
    patch :update, id: @ticketcategory, ticketcategory: { category: @ticketcategory.category, owner_id: @ticketcategory.owner_id }
    assert_redirected_to ticketcategory_path(assigns(:ticketcategory))
  end

  test "should destroy ticketcategory" do
    assert_difference('AssetsTicketcategory.count', -1) do
      delete :destroy, id: @ticketcategory
    end

    assert_redirected_to ticketcategories_path
  end
end
