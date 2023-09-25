class Post < ApplicationRecord
  belongs_to :topic,optional:true
  has_many :post_comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags
  has_one_attached :image

  validates :name, presence: true, length: {maximum: 250}
  validates :description, presence: true
  def ratings_by_value
    ratings.group(:value).count
  end


end
