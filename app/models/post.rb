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
  scope :created_between,-> (from_date, to_date){
    to_date = Date.today if to_date.blank?
    to_date= to_date.to_date
    where('created_at >= ? and created_at<= ?',from_date,to_date.end_of_day)
  }

end
