class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :position

  validates_presence_of :first_name, :last_name, :email, :user, :position

end
