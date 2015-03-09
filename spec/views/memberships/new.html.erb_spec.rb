require 'rails_helper'

RSpec.describe "memberships/new", :type => :view do
  before(:each) do
    assign(:membership, Membership.new(
      :name => "MyString",
      :typeof => "MyString",
      :user_id => 1,
      :group_id => 1,
      :owner_id => 1
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input#membership_name[name=?]", "membership[name]"

      assert_select "input#membership_typeof[name=?]", "membership[typeof]"

      assert_select "input#membership_user_id[name=?]", "membership[user_id]"

      assert_select "input#membership_group_id[name=?]", "membership[group_id]"

      assert_select "input#membership_owner_id[name=?]", "membership[owner_id]"
    end
  end
end
