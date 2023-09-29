class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    can :read, Post
    can :create, Post
    can :update, Post, user_id: user.id # Correctly reference user_id
    can :destroy, Post, user_id: user.id

    can :create, PostComment
    can :update, PostComment, user_id: user.id # Correctly reference user_id
    can :destroy, PostComment, user_id: user.id
  end
end
