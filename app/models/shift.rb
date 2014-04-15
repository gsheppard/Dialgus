class Shift < ActiveRecord::Base
  validates_presence_of :employee, :schedule, :start_time, :end_time
  validate :must_be_within_seven_days_of_week_start

  belongs_to :employee
  belongs_to :schedule

  def must_be_within_seven_days_of_week_start
    if !start_time.nil? && (start_time <= self.schedule.week_of || start_time >= self.schedule.week_of.end_of_week(:sunday))
      errors.add(:start_time, "must be within 7 days of week start date")
    end
  end
end

