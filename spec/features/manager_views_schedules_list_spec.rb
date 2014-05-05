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
  let!(:week) do
    w = FactoryGirl.build(:schedule, user: user)
    w.id = w.week_of.strftime("%Y%m%d").to_i
    w.save
    w
  end
  let!(:employees) { FactoryGirl.create_list(:employee, 5, user: user) }

  context "signed in", js: true do
    before :each do
      @date = DateTime.now.utc.beginning_of_day
      sign_in_as(user)
      visit schedules_path
    end

    scenario "sees calendar of current month" do
      expect(page).to have_content(@date.strftime('%b %Y'))
    end

    xscenario "click on existing schedule-week" do
      sunday = week.week_of.strftime("%Y-%m-%d")

      # rspec is not loading the JS the way I thought it was
      # and therefore is not activating the JS-link
      # to a given schedule page
      find(".fc-day[data-date='#{sunday}']").click
      expect(current_path).to eq(schedule_path(week))
    end

    xscenario "click on non-existent schedule-week" do
      next_sunday = (week.week_of + 1.weeks).strftime("%Y-%m-%d")

      # rspec is not loading the JS the way I thought it was
      find(".fc-day[data-date='#{next_sunday}']").click
      expect(page).to have_content("Create new schedule for week of #{next_sunday.delete('-')}")
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
