require 'spec_helper'

describe Request do

  it { should belong_to :user }
  it { should belong_to :employee }

  it { should validate_presence_of :user }
  it { should validate_presence_of :employee }
  it { should validate_presence_of :request_date }
  it { should validate_presence_of :request_type }
end
