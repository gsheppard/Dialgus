require 'spec_helper'

describe Position do

  context 'validations' do
    let(:user) { FactoryGirl.create(:user) }
    let(:position1) { FactoryGirl.create(:position, user: user) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :user }

    it 'should have unique name scoped to user' do
      position2 = FactoryGirl.build(:position, name: position1.name, user: user)

      expect(position2).to_not be_valid
    end

    it 'should allow duplicate positions if they belong to separate users' do
      position2 = FactoryGirl.build(:position, name: position1.name)

      expect(position2).to be_valid
    end
  end

  context 'associations' do
    it { should belong_to :user }
    it { should have_many :employees }
  end

end
