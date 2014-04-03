require 'spec_helper'

feature 'manager create account', %q{
  As a manager
  I want to be able to create an account
  So that I can use the site's features
} do

  # Acceptance Criteria
  # - I must enter a valid unique email
  # - I must enter a password
  # - I must confirm my password
  # - If I do not enter all required information, I receive an error
  # - I receive an error message if I provided an invalid email
  # - I receive an error message if my email is not unique
  # - I receive an error message if my password does not match up

  scenario 'navigate to create account page' do
    visit new_user_registration_path

    expect(page).to have_content('Create Account')
  end

  scenario 'create account with valid attributes' do
    visit new_user_registration_path
    user = FactoryGirl.build(:user)

    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password

    click_button 'Create'

    expect(page).to have_content('Account successfully created.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'attempt to create account with invalid attributes' do
    visit new_user_registration_path

    click_button 'Create'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'ensure email uniqueness' do
    user_1 = FactoryGirl.create(:user)
    user_2 = FactoryGirl.build(:user)

    visit new_user_registration_path

    fill_in 'First Name', with: user_2.first_name
    fill_in 'Last Name', with: user_2.last_name
    fill_in 'Email', with: user_1.email
    fill_in 'user_password', with: user_2.password
    fill_in 'user_password_confirmation', with: user_2.password

    click_button 'Create'

    expect(page).to have_content('has already been taken')
    expect(page).to_not have_content('Sign Out')
  end

end
