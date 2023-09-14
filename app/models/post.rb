class Post < ApplicationRecord
  belongs_to :topic

  validates :name, presence: true, length: {maximum: 250}
  validates :description, presence: true
end
