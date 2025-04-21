FactoryBot.define do
  factory :review_tag do
    association :review
    association :tag
  end
end
