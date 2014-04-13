require 'spec_helper'

describe Position do

  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }

    it { should validate_uniqueness_of(:name).scoped_to(:user) }
  end

  context 'associations' do
    it { should belong_to :user }
    it { should have_many :employees }
  end

end
