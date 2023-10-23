# Preview all emails at http://localhost:3000/rails/mailers/new_user_sign_up_mailer
class NewUserSignUpMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_user_sign_up_mailer/new_user_sign_up
  def new_user_sign_up
    user = User.create(email: 'user@example.com', name: 'John Doe', password: '123456')
    NewUserSignUpMailer.new_user_sign_up(user)
  end

end
