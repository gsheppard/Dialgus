require 'spec_helper'

feature 'user signs out', %q{
  As an authenticated user
  I want to be able to sign out
  So that my information is secure
} do

  # Acceptance Criteria
  # - Click 'Sign Out' link
  # - Verify that the session is completed

  scenario 'user signs out successfully' do
    sign_in_as(FactoryGirl.create(:user))

    visit employees_path
    click_link 'Sign Out'

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Signed out successfully.')
  end

  scenario 'link is not present when not logged in' do
    visit root_path

    expect(page).to_not have_content('Start Scheduling')
  end

end
