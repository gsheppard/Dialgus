require 'spec_helper'

feature 'user signs in', %q{
  As an authenticated user
  I want to sign in
  So I can access my account and site features
} do

  # Acceptance Criteria
  # - Sign in link
  # - Accepts matching email and password for log in
  # - Shows errors for invalid email
  # - Shows errors for invalid password on valid email

  before :each do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
  end

  scenario 'presence of sign in link' do
    visit root_path
    expect(page).to have_content('Sign In')
  end

  scenario 'sign in with valid information' do

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    within(:css, '.form-actions') do
      click_on 'Sign In'
    end

    expect(page).to have_content(@user.first_name)
    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'attempt sign in with invalid email' do
    fill_in 'Email', with: 'blargh@email.com'
    fill_in 'Password', with: @user.password

    within(:css, '.form-actions') do
      click_on 'Sign In'
    end

    expect(page).to have_content('Invalid email or password.')
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Sign Out')

  end

  scenario 'attempt sign in with valid email and invalid password'

end
