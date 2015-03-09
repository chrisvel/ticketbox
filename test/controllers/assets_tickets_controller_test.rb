require 'test_helper'

class AssetsTicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('AssetsTicket.count') do
      post :create, ticket: { category_id: @ticket.category_id, date_closed: @ticket.date_closed, date_opened: @ticket.date_opened, explanation: @ticket.explanation, issue: @ticket.issue, owner_id: @ticket.owner_id, remedy: @ticket.remedy, severity: @ticket.severity, status: @ticket.status, user_id: @ticket.user_id }
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket
    assert_response :success
  end

  test "should update ticket" do
    patch :update, id: @ticket, ticket: { category_id: @ticket.category_id, date_closed: @ticket.date_closed, date_opened: @ticket.date_opened, explanation: @ticket.explanation, issue: @ticket.issue, owner_id: @ticket.owner_id, remedy: @ticket.remedy, severity: @ticket.severity, status: @ticket.status, user_id: @ticket.user_id }
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should destroy ticket" do
    assert_difference('AssetsTicket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to tickets_path
  end
end
