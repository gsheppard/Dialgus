require 'spec_helper'

describe Schedule do
  it { should validate_presence_of :week_of }
  it { should validate_presence_of :user }

  it { should belong_to :user }

  it 'should be a sunday' do
    user = FactoryGirl.create(:user)

    week1 = FactoryGirl.build(:schedule, week_of: DateTime.new(2014,4,13), user: user)
    expect(week1).to be_valid

    week2 = FactoryGirl.build(:schedule, week_of: DateTime.new(2014,4,14), user: user)
    expect(week2).to_not be_valid
  end

end
