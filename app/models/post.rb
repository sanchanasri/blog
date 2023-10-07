class Post < ApplicationRecord
  belongs_to :topic,optional:true
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags
  has_one_attached :image
  has_and_belongs_to_many :users

  validates :name, presence: true, length: {maximum: 250}
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
  def unread?
    # Implement your logic here to determine if the post is unread
    # For example, you can check if the post is associated with the current_user
    !user.posts.include?(self) # Assuming you have a user association
  end

end
