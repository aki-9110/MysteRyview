module StepForm
  class Book
    include ActiveModel::Model
    include ActiveModel::Validations

    validates :title, presence: true, length: { maximum: 255 }
    validates :author, presence: true, length: { maximum: 255 }

    attr_accessor :title, :author
  end
end
