class Rating < ApplicationRecord
  belongs_to :post
  after_create :update_ratings

  def update_ratings
    post.update_ratings
  end
end
