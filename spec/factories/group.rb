FactoryGirl.define do
  factory :group do
   sequence(:title) { |n| "Test group #{n}"}
   description { Faker::Lorem.paragraph(3)}
  end
end