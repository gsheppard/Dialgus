require 'spec_helper'

feature 'manager views schedules list', %q{
  As a manager
  I want to be able to make schedules
  For the employees in the list
} do

  # When I log in, I am presented with the current week's schedules
  # The list is labeled with the sunday that the week starts on
  # The list is sorted by most recent date
  # Each item links to the full schedule layout

  before :each do
    @user = FactoryGirl.create(:user)
    Schedule.new(week_of: DateTime.new(2014, 4, 13), user: @user)
    sign_in_as(@user)
  end

  scenario "after log in, I'm redirected to the schedules list path" do
    expect(current_path).to eq(schedules_path)
  end

  scenario "views a list of the created schedules" do
    expect(page).to have_content("April 13, 2014")
  end
end
