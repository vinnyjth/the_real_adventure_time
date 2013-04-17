FactoryGirl.define do
  factory :page do
    sequence(:title) { |n| "Test Page #{n}"}
    stamp 'this is a note'
    content { Faker::Lorme.paragraph(3)}
    group FactoryGirl.create(:group)
  end
end