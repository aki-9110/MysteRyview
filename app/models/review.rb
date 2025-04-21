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
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags

  has_one_attached :image

  # フォームからのタグの入力を仮想属性として受け取る
  attr_accessor :tag_names

  before_validation :set_tag  # 保存前に仮想属性をセット
  after_save :save_tags # 保存後にタグを処理する

  # 特定のタグを取得する
  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  # エラー時に入力内容を保持するために保存前に既存のタグをtag_namesにセットする
  def set_tag
    self.tag_names ||= tags.map(&:name).join(", ")
  end

  def save_tags
    # tag_namesが未入力の状態なら処理を返す
    return if tag_names.blank?

    # カンマ区切りの文字列を配列に変換する
    tag_list = tag_names.split(",").map(&:strip).uniq

    # 既存のタグを取得し、なければ作成
    tag_list.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      self.tags << tag unless self.tags.include?(tag)
    end
  end

  # tagのパラメータを受け取ってそのtagを含むreviewを返すメソッド
  def self.include_tag(params)
    if (tag_name = params)
      self.with_tag(tag_name)
    else
      self.all
    end
  end

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
