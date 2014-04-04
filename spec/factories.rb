FactoryGirl.define do
  factory :user do
    first_name 'Dean'
    last_name 'Winchester'
    password 'password'
    password_confirmation 'password'
    sequence(:email) {|n| "example#{n}@email.com"}
  end

  factory :position do
    sequence(:name) {|n| "Position#{n}_" }

    user
  end

  types = ['FT', 'PT']

  factory :employee do
    first_name 'Sam'
    last_name 'Winchester'
    work_type types.sample
    sequence(:email) {|n| "sam.#{n}.winchester@email.com" }

    position
    user
  end
end
