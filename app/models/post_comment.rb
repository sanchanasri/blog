class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :name ,presence: true
  validates :description, presence: true
  has_many :user_comment_ratings
end
