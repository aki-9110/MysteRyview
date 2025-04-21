FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "sample_#{n}" }
  end
end
