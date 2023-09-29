class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user,  foreign_key: true
    default_user = User.find_by(email: 'sanchana@gmail.com')
    Post.where(user_id: nil).update_all(user_id: default_user.id)

  end
end
