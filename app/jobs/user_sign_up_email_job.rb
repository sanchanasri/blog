class UserSignUpEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    NewUserSignUpMailer.new_user_sign_up(user).deliver_now
  end
end
