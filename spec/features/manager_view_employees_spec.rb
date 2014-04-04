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

  before :each do
    @user = FactoryGirl.create(:user)
    @employees = []
    10.times do
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

  scenario 'see link for adding new employees' do
    sign_in_as(@user)
    visit employees_path

    page.should have_selector(:link_or_button, 'Add')
  end

  scenario 'Unauthorized user cannot view' do
    visit employees_path

  end

end
