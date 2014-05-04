require 'spec_helper'

feature 'manager adds positions', %q{
  As a manager
  I want to be able to add Positions
  So I can create new positions for my employees
} do

  # Acceptance Criteria
  # - Form for adding new position
  # - Only takes a name

  context 'Position for a single user' do
    before :each do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      @position = FactoryGirl.create(:position, name: 'Launcher', user: user)
      @prev_count = Position.count

      visit employees_path
    end

    scenario 'add new position with valid attributes' do
      # fill_in 'Name', with: 'Experience Engineer'

      within(:css, '.new_position') do
        fill_in 'position_name', with: 'Experience Engineer'
        click_button 'Add'
      end

      expect(current_path).to eq(employees_path)
      expect(page).to have_content(@position.name)
      expect(Position.count).to eq(@prev_count + 1)
    end

    scenario 'attempt new positions with invalid attributes' do
      within(:css, '.new_position') do
        click_button 'Add'
      end

      expect(page).to have_content("can't be blank")
      expect(Position.count).to eq(@prev_count)
    end

    scenario 'attempt new repeated position' do
      within(:css, '.new_position') do
        fill_in 'position_name', with: 'Launcher'
        click_button 'Add'
      end

      expect(page).to have_content("already been taken")
      expect(Position.count).to eq(@prev_count)
    end
  end

  context 'Positions are unique to user' do
    scenario 'Create position taht belongs to another user' do
      position1 = FactoryGirl.create(:position)
      position2 = FactoryGirl.create(:position)
      prev_count = Position.count

      sign_in_as(position1.user)
      visit employees_path

      within(:css, '.new_position') do
        fill_in 'position_name', with: position2.name
        click_button 'Add'
      end

      expect(page).to have_content("Position created")
      expect(Position.count).to eq(prev_count + 1)
    end

  end

end
