class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    # Admin User has full access everywhere
    if user.role?(:admin)
      can :manage, :all
    elsif user.role?(:moderator) # Moderator Role can create and read Projects
      #can :create, Project
      #can :read, Project
      can [:create, :read, :update], Project
      # can [:create, :read, :update], [Project, Task]

    elsif user.role?(:user) # User Role just can read Projects
      can :read, Project
    end

    

  end
end
