require 'spec_helper'

feature 'manager adds employees', %q{
  As a manager
  I want to be able to add employees
  So that I can make schedules for them
} do

  # Requires first name, last name, email, position, and work type
  # Employees with duplicated email addresses cannot be made

  context 'signed in' do
    before :each do
      @user = FactoryGirl.create(:user)
      @position = FactoryGirl.create(:position, user: @user)
      @existing_employee = FactoryGirl.create(
        :employee,
        position: @position,
        user: @user
      )
      @new_employee = FactoryGirl.build(
        :employee,
        position: @position,
        user: @user
      )

      @prev_count = @user.employees.count
      sign_in_as(@user)
      visit employees_path
    end

    scenario 'create with valid attributes' do
      fill_in 'First name', with: @new_employee.first_name
      fill_in 'Last name', with: @new_employee.last_name
      fill_in 'Email', with: @new_employee.email

      select @position.name, from: 'Position'
      choose @new_employee.work_type

      within(:css, '#new_employee') do
        click_on 'Add'
      end

      expect(@user.employees.count).to eq(@prev_count + 1)
      expect(page).to have_content(@new_employee.email)
    end

    scenario 'attempt with invalid attrbiutes' do
      within(:css, '#new_employee') do
        click_on 'Add'
      end

      expect(page).to have_content("can't be blank")
      expect(@user.employees.count).to eq(@prev_count)
    end

    scenario 'attempt with duplicated email' do
      fill_in 'First name', with: @new_employee.first_name
      fill_in 'Last name', with: @new_employee.last_name
      fill_in 'Email', with: @existing_employee.email

      select @position.name, from: 'Position'
      choose @new_employee.work_type

      within(:css, '#new_employee') do
        click_on 'Add'
      end

      expect(page).to have_content("has already been taken")
      expect(@user.employees.count).to eq(@prev_count)
    end
  end

end
