require 'rails_helper'

RSpec.describe "memberships/index", :type => :view do
  before(:each) do
    assign(:memberships, [
      Membership.create!(
        :name => "Name",
        :typeof => "Typeof",
        :user_id => 1,
        :group_id => 2,
        :owner_id => 3
      ),
      Membership.create!(
        :name => "Name",
        :typeof => "Typeof",
        :user_id => 1,
        :group_id => 2,
        :owner_id => 3
      )
    ])
  end

  it "renders a list of memberships" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Typeof".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
