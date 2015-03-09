require 'rails_helper'

RSpec.describe "groups/edit", :type => :view do
  before(:each) do
    @group = assign(:group, Group.create!(
      :name => "MyString",
      :owner_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit group form" do
    render

    assert_select "form[action=?][method=?]", group_path(@group), "post" do

      assert_select "input#group_name[name=?]", "group[name]"

      assert_select "input#group_owner_id[name=?]", "group[owner_id]"

      assert_select "input#group_user_id[name=?]", "group[user_id]"
    end
  end
end
