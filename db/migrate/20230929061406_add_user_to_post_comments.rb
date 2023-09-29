class AddUserToPostComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :post_comments, :user,  foreign_key: true
    default_user = User.find_by(email: 'sanchana@gmail.com')
    PostComment.where(user_id: nil).update_all(user_id: default_user.id)

  end
end
