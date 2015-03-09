require 'rails_helper'

RSpec.describe "memberships/show", :type => :view do
  before(:each) do
    @membership = assign(:membership, Membership.create!(
      :name => "Name",
      :typeof => "Typeof",
      :user_id => 1,
      :group_id => 2,
      :owner_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Typeof/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
