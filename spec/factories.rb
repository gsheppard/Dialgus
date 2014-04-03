FactoryGirl.define do
  factory :user do
    first_name 'Dean'
    last_name 'Winchester'
    password 'password'
    password_confirmation 'password'
    sequence(:email) {|n| "example#{n}@email.com"}
  end
end
