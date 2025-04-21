class Review < ApplicationRecord
  validates :non_spoiler_text, presence: true, length: { maximum: 500 }
  validates :spoiler_text, length: { maximum: 1000 }
  validates :foreshadowing, length: { maximum: 500 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :image

  # bookのパラメータを含めてreviewを作成するメソッド
  def self.build_with_book(params)
    book = Book.find_or_create_by(title: params[:book_title], author: params[:book_author])
    new(params.except(:book_title, :book_author).merge(book: book))
  end

  # bookパラメータを含めてReviewを更新するメソッド
  def update_with_book(params)
    book = Book.find_or_create_by(title: params[:book_title], author: params[:book_author])
    update(params.except(:book_title, :book_author).merge(book: book))
  end

  def self.ransackable_associations(auth_object = nil)
    [ "book" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "created_at", "updated_at" ]
  end
end
