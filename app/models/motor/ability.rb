##
# CanCan permissions for motor_admin
module Motor
  class Ability
    include CanCan::Ability

    def initialize(user, _request)
      case user.role
      when 'organization_admin'
        can :manage, :all
      end
    end
  end
end
