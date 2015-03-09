require 'rails_helper'

RSpec.describe "groups/new", :type => :view do
  before(:each) do
    assign(:group, Group.new(
      :name => "MyString",
      :owner_id => 1,
      :user_id => 1
    ))
  end

  it "renders new group form" do
    render

    assert_select "form[action=?][method=?]", groups_path, "post" do

      assert_select "input#group_name[name=?]", "group[name]"

      assert_select "input#group_owner_id[name=?]", "group[owner_id]"

      assert_select "input#group_user_id[name=?]", "group[user_id]"
    end
  end
end
