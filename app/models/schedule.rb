class Schedule < ActiveRecord::Base
  validates_presence_of :week_of, :user
  validate :must_be_a_sunday

  belongs_to :user

  def must_be_a_sunday
    if !week_of.nil? && week_of != week_of.at_beginning_of_week(:sunday)
      errors.add(:week_of, "must be a Sunday")
    end
  end
end
