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
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    positions = []
    5.times do
      positions << FactoryGirl.create(:position, user: user)
    end

    visit positions_path

    positions.each do |pos|
      expect(page).to have_content(pos.name)
    end

  end

  scenario 'expect different users to have different positions' do
    # create positions assigned to a user
    user_1 = FactoryGirl.create(:user)
    positions_1 = []
    5.times do
      positions_1 << FactoryGirl.create(:position, user: user_1)
    end

    # create positions assigned to a different user
    user_2 = FactoryGirl.create(:user)
    positions_2 = []
    5.times do
      positions_2 << FactoryGirl.create(:position, user: user_2)
    end

    # sign in as second user
    sign_in_as(user_2)
    visit positions_path

    # check that page has correct content and
    # does not have incorrect content
    5.times do |n|
      expect(page).to have_content(positions_2[n].name)
      expect(page).to_not have_content(positions_1[n].name)
    end
  end

  scenario 'see delete and add links' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:position, user: user)

    sign_in_as(user)
    visit positions_path

    page.should have_selector(:link_or_button, 'Add')
    page.should have_link('Remove')

  end

  scenario 'Unviewable by unauthenticated users' do
    user = FactoryGirl.create(:user)

    positions = []
    3.times do
      positions << FactoryGirl.create(:position, user: user)
    end

    visit positions_path

    positions.each do |pos|
      expect(page).to_not have_content(pos.name)
    end

    expect(page).to_not have_content('Remove')
    expect(page).to have_content('Access Denied')
  end

end
