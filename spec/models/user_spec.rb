require 'spec_helper'

describe User do

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it { should have_valid(:first_name).when('Dean', 'Sam') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Winchester', 'Kent') }
  it { should_not have_valid(:last_name).when(nil, '') }

end
