require 'spec_helper'

feature 'employee time off requests', %q{
  As a manager
  I want to add time off requests for employees
  So that I don't schedule them on those days
} do

  # manager can create a time off request for an employee
  # form requires employee, date, and type
  #
  #

  let(:user) { FactoryGirl.create(:user) }
  let!(:employees) { FactoryGirl.create_list(:employee, 3, user: user) }

  before :each do
    sign_in_as(user)
    @prev_count = user.requests.count
    visit requests_path
  end

  scenario "create time off request for an employee" do
    select employees.first.first_name
    fill_in "Request date", with: "04/03/2014"
    select "Vacation"

    within(:css, '.new_request') { click_on 'Add' }

    expect(user.requests.count).to eq(@prev_count + 1)
  end

  scenario "attempt with no values" do
    within(:css, '.new_request') { click_on 'Add' }

    expect(user.requests.count).to eq(@prev_count)
    within(:css, '.requests') do
      expect(page).to_not have_content(employees.first.first_name)
    end
  end

end
