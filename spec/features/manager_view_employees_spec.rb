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
    @employees = []
    10.times do
      @employees << FactoryGirl.create(:employee)
    end

    visit '/employees'
  end

  scenario 'view list of employees' do
    @employees.each do |emp|
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.position)
      expect(page).to have_content(user.type)
    end
  end

  scenario 'see link for adding new employees'
  scenario 'Unauthorized user cannot view'

end
