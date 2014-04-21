class Request < ActiveRecord::Base
  belongs_to :employee
  belongs_to :user

  validates_presence_of :user, :employee, :request_date, :request_type
end
