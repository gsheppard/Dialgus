require 'spec_helper'

describe Shift do

  it { should validate_presence_of :employee }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :end_time }

  it { should belong_to :employee }
  it { should belong_to :schedule }

  context 'start time within 7 days of week start date' do
    it 'has a valid date if within 7 days' do
      week = FactoryGirl.create(:schedule)
      employee = FactoryGirl.create(:employee)
      shift = Shift.new(
        employee: employee,
        schedule: week,
        start_time: DateTime.new(week.week_of.year, week.week_of.month, week.week_of.day, 12, 30),
        end_time: DateTime.new(week.week_of.year, week.week_of.month, week.week_of.day, 9, 30)
      )

      expect(shift).to be_valid
    end

    it 'has an invalid date if outside of 7 days' do
      week = FactoryGirl.create(:schedule)
      next_week = week.week_of + 8.days
      employee = FactoryGirl.create(:employee)
      shift = Shift.new(
        employee: employee,
        schedule: week,
        start_time: DateTime.new(next_week.year, next_week.month, next_week.day, 12, 30),
        end_time: DateTime.new(next_week.year, next_week.month, next_week.day, 9, 30)
      )

      expect(shift).to_not be_valid
    end
  end

end
