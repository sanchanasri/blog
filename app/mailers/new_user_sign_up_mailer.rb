class NewUserSignUpMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_user_sign_up_mailer.new_user_sign_up.subject
  #
  def new_user_sign_up(user)
    @user= user
    @greeting = "Hi"
    mail(to: @user.email,subject: 'account created successfully!!')
  end
end
