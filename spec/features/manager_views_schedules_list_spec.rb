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

  let(:user) { FactoryGirl.create(:user) }
  let!(:week) { FactoryGirl.create(:schedule, user: user) }

  context "signed in" do
    before :each do
      sign_in_as(user)
    end

    scenario "after log in, I'm redirected to the schedules list path" do
      expect(current_path).to eq(schedules_path)
    end

    scenario "views a list of the created schedules" do
      expect(page).to have_content(week.week_of.strftime("%b %d, %Y"))
    end

    scenario "cannot see other users' schedules" do
      other_week = FactoryGirl.create(:schedule, week_of: DateTime.now.beginning_of_week(:sunday) + 1.weeks)
      visit current_path

      expect(page).to_not have_content(other_week.week_of.strftime("%b %d, %Y"))
    end
  end

  context "not signed in" do
    scenario "unauthorized access" do
      visit schedules_path

      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(page).to_not have_content(week.week_of.strftime("%b %d, %Y"))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end