require 'rails_helper'

RSpec.describe "groups/show", :type => :view do
  before(:each) do
    @group = assign(:group, Group.create!(
      :name => "Name",
      :owner_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
