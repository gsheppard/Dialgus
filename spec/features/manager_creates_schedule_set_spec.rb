require 'spec_helper'

feature "manager creates schedule set", %q{
  As a manager
  I want to be able to make schedules
  For the employees in the list
} do

  # After submitting the "add schedule" button, I am directed
  # => to a blank schedule template in the form of a grid
  # Along the left side (first column) is a list of employees.
  # Along the top (first row) are the dates for that week, starting with Sunday.
  # Each cell contains a start and end time drop down list
  # Times can be selected based on 15 minute increments
  # When I am finished, I can choose to save the schedule
  # => and it becomes part of the viewable schedules

  let(:user) { FactoryGirl.create(:user) }
  let(:sunday) { DateTime.now.beginning_of_week(:sunday) }
  let(:employees) { FactoryGirl.create_list(:employee, 5, user: user) }

  before :each do
    sign_in_as(user)
    visit schedules_path
  end

  scenario "expect list of upcoming weeks" do
    upcoming = [sunday + 1.weeks, sunday + 2.weeks, sunday + 3.weeks, sunday + 4.weeks]

    upcoming.each do |week|
      expect(page).to have_content(week.strftime("%b %d, %Y"))
    end
  end

  scenario "create new week's worth of schedules" do
    select (sunday + 1.weeks).strftime("%b %d, %Y"), from: "Week of"

    within(:css, ".new_schedule") do
      click_on "Create"
    end

    expect(user.schedules.first.shifts.count).to eq(user.employees.count * 7)
  end
end
