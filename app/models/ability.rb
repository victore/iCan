class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    # Admin User has full access everywhere
    if user.role?(:admin)
      can :manage, :all
    elsif user.role?(:moderator) # Moderator Role can create and read Projects
      #can [:create, :read, :update], Project
      # can [:create, :read, :update], [Project, Task]
      can :create, Project
      can :update, Project do |project|
        project.ongoing?
      end
      can :read, Project
    elsif user.role?(:user) # User Role just can read Projects
      #can :read, Project
      can :read, Project, ongoing: true
    end

  end

end
