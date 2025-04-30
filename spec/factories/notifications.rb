FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user   # 通知を送った人
    association :visited, factory: :user   # 通知を受け取る人
    action { "like" }
    read { false }

    association :notifiable, factory: :like
  end
end
