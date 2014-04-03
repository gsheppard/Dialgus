require 'spec_helper'

feature 'manager views positions', %q{
  As a manager
  I want to see a list of positions
  So I can add more or delete them
} do

  # Acceptance Criteria
  # - View list of positions
  # - See delete links next to each
  # - See add new button
  # - Page is not accessbile by unauthenticated users

  scenario 'view positions' do
    visit '/positions'

    positions = []
    5.times do
      positions << FactoryGirl.create(:position)
    end

    position.each do |pos|
      expect(page).to have_content(pos.name)
    end

  end

  scenario 'see delete and add links'
  scenario 'Unviewable by unauthenticated users'

end
