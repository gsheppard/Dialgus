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
  let!(:employees) { FactoryGirl.create_list(:employee, 5, user: user) }

  context "signed in" do
    before :each do
      sign_in_as(user)
      date = DateTime.now.utc.beginning_of_day
      visit schedules_path
    end

    scenario "sees calendar of current month"
    scenario "click on existing schedule-week"
    scenario "click on non-existent schedule-week"

    # scenario "views a list of the created schedules" do
    #   expect(page).to have_content(week.week_of.strftime("%b %d, %Y"))
    # end

    # scenario "cannot see other users' schedules" do
    #   other_week = FactoryGirl.create(:schedule, week_of: DateTime.now.beginning_of_week(:sunday) + 2.weeks)
    #   visit current_path

    #   within(:css, ".schedules_list") do
    #     expect(page).to_not have_content(other_week.week_of.strftime("%b %d, %Y"))
    #   end
    # end
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
