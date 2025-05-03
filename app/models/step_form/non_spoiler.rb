module StepForm
  class NonSpoiler
    include ActiveModel::Model
    include ActiveModel::Validations

    validates :non_spoiler_text, presence: true, length: { maximum: 500 }

    attr_accessor :non_spoiler_text
  end
end