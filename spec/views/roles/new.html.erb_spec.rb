require 'rails_helper'

RSpec.describe "roles/new", :type => :view do
  before(:each) do
    assign(:role, Role.new(
      :name => "MyString",
      :level => "MyString",
      :user_id => 1,
      :group_id => 1,
      :owner_id => 1
    ))
  end

  it "renders new role form" do
    render

    assert_select "form[action=?][method=?]", roles_path, "post" do

      assert_select "input#role_name[name=?]", "role[name]"

      assert_select "input#role_level[name=?]", "role[level]"

      assert_select "input#role_user_id[name=?]", "role[user_id]"

      assert_select "input#role_group_id[name=?]", "role[group_id]"

      assert_select "input#role_owner_id[name=?]", "role[owner_id]"
    end
  end
end
