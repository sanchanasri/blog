class CreateUserPostReadStatus < ActiveRecord::Migration[7.0]
  def change
    create_table :user_post_read_statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.boolean :read

      t.timestamps
    end
  end
end
