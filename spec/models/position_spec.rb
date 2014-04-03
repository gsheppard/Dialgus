require 'spec_helper'

describe Position do

  context 'validations' do
    it { should validate_presence_of :name }

    it { should have_valid(:name).when('Launcher', 'Advisor') }
    it { should_not have_valid(:name).when(nil, '') }
  end

  context 'associations' do
    it { should belong_to :user }
    # it { should have_many :employees }
  end

end
