class Position < ActiveRecord::Base
  belongs_to :user
  has_many :employees

  validates_presence_of :user, :name
  validates_uniqueness_of :name, scope: :user
end
