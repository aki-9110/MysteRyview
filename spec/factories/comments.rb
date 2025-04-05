FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "本文#{n}" }
    association :user
    association :review
  end
end
