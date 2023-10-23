class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :post_comments
  has_and_belongs_to_many :posts
  has_many :user_comment_ratings
  after_create :new_user_sign_up_email

  def new_user_sign_up_email
    UserSignUpEmailJob.perform_later(self)
  end
end
