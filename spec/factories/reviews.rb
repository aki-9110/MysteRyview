FactoryBot.define do
  factory :review do
    non_spoiler_text { "sample_text" }
    spoiler_text { "sample_spoiler_text" }
    foreshadowing { "sample_foreshadowing" }
    rating { 5 }
  end
end
