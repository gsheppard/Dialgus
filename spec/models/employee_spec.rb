require 'spec_helper'

describe Employee do

  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :user }
    it { should validate_presence_of :position }
  end

  context 'associations' do
    it { should belong_to :user }
    it { should belong_to :position }
  end

end
