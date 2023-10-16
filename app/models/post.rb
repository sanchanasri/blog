class Post < ApplicationRecord
  belongs_to :topic,optional:true
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags
  has_one_attached :image
  has_and_belongs_to_many :users


  validates :name, presence: true, length: {maximum: 20}
  validates :description, presence: true

  def ratings_by_value
    ratings.group(:value).count
  end
  def average_rating
    if ratings.present?
    ratings.average(:value)
    else
      0.0
      end
  end

end
