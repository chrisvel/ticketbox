require 'rails_helper'

RSpec.describe "roles/index", :type => :view do
  before(:each) do
    assign(:roles, [
      Role.create!(
        :name => "Name",
        :level => "Level",
        :user_id => 1,
        :group_id => 2,
        :owner_id => 3
      ),
      Role.create!(
        :name => "Name",
        :level => "Level",
        :user_id => 1,
        :group_id => 2,
        :owner_id => 3
      )
    ])
  end

  it "renders a list of roles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Level".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
