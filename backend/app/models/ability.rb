class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :manage, [:menu]
      cannot :access, :rails_admin
    else
      cannot :manage, :all
    end
  end
end
