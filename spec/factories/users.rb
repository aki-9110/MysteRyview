FactoryBot.define do
  factory :user do
    name { "sample_user" }
    sequence(:email) { |n| "sample_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
