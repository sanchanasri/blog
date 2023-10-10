class UserCommentRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_comment_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_comment, null: false, foreign_key: true
      t.integer :CommentRating

      t.timestamps
    end
  end
end
