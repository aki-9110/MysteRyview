module StepForm
  class Spoiler
    include ActiveModel::Model
    include ActiveModel::Validations

    validates :spoiler_text, length: { maximum: 1000 }
    validates :foreshadowing, length: { maximum: 500 }

    attr_accessor :spoiler_text, :foreshadowing
  end
end