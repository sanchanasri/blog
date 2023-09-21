class Post < ApplicationRecord
  belongs_to :topic,optional:true
  has_many :post_comments, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :name, presence: true, length: {maximum: 250}
  validates :description, presence: true
end
