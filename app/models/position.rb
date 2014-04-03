class Position < ActiveRecord::Base
  belongs_to :user
  has_many :employees

  validates_presence_of :name, :user
end
