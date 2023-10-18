class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :post_comments_count
  validates :name ,presence: true
  validates :description, presence: true
  has_many :user_comment_ratings
end
