class PostComment < ApplicationRecord
  belongs_to :post
  validates :name ,presence: true
  validates :description, presence: true
end
