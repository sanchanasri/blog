FactoryBot.define do
  factory :user_comment_rating do
    user { nil }
    post_comment { nil }
    CommentRating { 1 }
  end
end
