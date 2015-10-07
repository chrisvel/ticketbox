require 'rails_helper'
require 'user'

feature "Signing in" do
  background do
    @user = FactoryGirl.create :user
  end

  scenario "Signing in with correct credentials" do
    visit '/signin'
    within("#login-page") do
      fill_in 'Email', :with => 'someone@somewhere.com'
      fill_in 'Password', :with => '12345678'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

  given(:jack) { @jack = FactoryGirl.build :jack }

  scenario "Signing in as another user" do
    visit '/signin'
    within("#login-page") do
      fill_in 'Email', :with => jack.email
      fill_in 'Password', :with => jack.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password'
  end
end
