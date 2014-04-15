class Schedule < ActiveRecord::Base
  validates_presence_of :week_of, :user
  validate :must_be_a_sunday

  belongs_to :user
  has_many :shifts

  def must_be_a_sunday
    if !week_of.nil? && week_of.wday != 0
      errors.add(:week_of, "must be a Sunday")
    end
  end
end
