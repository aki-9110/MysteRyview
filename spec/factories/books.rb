FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "sample#{n}_title" }
    sequence(:author) { |n| "sample#{n}_author" }
  end
end
