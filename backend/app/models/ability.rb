class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      # can :manage, Post
      cannot :manage, Menu
      # can [:read, :create, :update], Post
    # elsif user.has_role? :guest
    #   can :read, Post
    else
      cannot :manage, all
    end
  end
end
