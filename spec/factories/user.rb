FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) { |n| "johndoe#{n}@example.com"}
    password 'changeme'
    password_confirmation 'changeme'

  end
end