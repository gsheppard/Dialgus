class Employee < ActiveRecord::Base
  belongs_to :user
  belongs_to :position

  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :first_name, :last_name, :email, :user, :position, :work_type
  validates_inclusion_of :work_type, in: ['FT', 'PT']
  validates_format_of :email, :with => EmailRegex

  def full_name
    first_name + ' ' + last_name
  end

end
