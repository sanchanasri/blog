# db/migrate/[timestamp]_create_posts_tags.rb
class CreatePostsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_tags, id: false do |t|
      t.references :post, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
