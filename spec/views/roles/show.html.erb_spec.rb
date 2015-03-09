require 'rails_helper'

RSpec.describe "roles/show", :type => :view do
  before(:each) do
    @role = assign(:role, Role.create!(
      :name => "Name",
      :level => "Level",
      :user_id => 1,
      :group_id => 2,
      :owner_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Level/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
