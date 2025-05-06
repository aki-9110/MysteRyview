module StepForm
  class AdditionalInfo
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    validates :rating, presence: true
    validates :tag_names, length: { maximum: 100 }

    attribute :rating, :integer
    attribute :tag_names, :string
    attribute :image

    # enumを利用したかったがActiveRecordモデルを継承していないので定数で星5評価のステータスを定義
    RATINGS = {
      very_poor: 1,
      poor: 2,
      fair: 3,
      good: 4,
      excellent: 5
    }
  end
end
