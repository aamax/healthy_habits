class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      cannot :manage, Contact
      can :read, Page
      cannot :manage, User

      can [:cleanse_notice], Contact
    end
  end
end
