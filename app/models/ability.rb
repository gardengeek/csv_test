class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:admin)
      can :manage, :all
    else
      can :manage, User, :id => user.id
    end
  end
end
