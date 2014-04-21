FactoryGirl.define do
  factory :user do
    first_name 'Dean'
    last_name 'Winchester'
    password 'password'
    password_confirmation 'password'
    sequence(:email) {|n| "example#{n}_@email.com"}
  end

  factory :position do
    sequence(:name) {|n| "Position#{n}_" }

    user
  end

  types = ['FT', 'PT']

  factory :employee do
    sequence(:first_name) {|n| "Sam#{n}_" }
    last_name 'Winchester'
    work_type types.sample
    sequence(:email) {|n| "sam.#{n}.winchester@email.com" }

    position
    user
  end

  factory :schedule do
    week_of DateTime.now.at_beginning_of_week(:sunday)

    user
  end
end
