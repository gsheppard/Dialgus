require 'spec_helper'

feature 'manager views emoployees', %q{
  As a manager
  I can view employees
  So I know who I manage
} do

  # Acceptance Criteria
  # - View list of current employees
  # - List includes name, email, position, type (FT/PT)
  # - link to add new employees
  # - Only authorized users can view

  context 'signed in as valid user' do
    before :each do
      @user = FactoryGirl.create(:user)
      @employees = []
      3.times do
        @employees << FactoryGirl.create(:employee, user: @user)
      end
    end

    scenario 'view list of employees' do
      sign_in_as(@user)
      visit employees_path

      @employees.each do |emp|
        expect(page).to have_content(emp.full_name)
        expect(page).to have_content(emp.email)
        expect(page).to have_content(emp.position.name)
        expect(page).to have_content(emp.work_type)
      end
    end

    scenario 'cannot view users by other employees' do
      sign_in_as(FactoryGirl.create(:user))
      visit employees_path

      @employees.each do |emp|
        expect(page).to_not have_content(emp.full_name)
        expect(page).to_not have_content(emp.email)
        expect(page).to_not have_content(emp.position.name)
      end
    end
  end

  context 'not signed in' do
    scenario 'Unauthorized user cannot view' do
      visit employees_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

end
