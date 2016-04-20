class MemberAbility < BaseAbility

  def initialize(user)
    can :manage, User, id: user.id

    cannot :show, :admin_controllers
    cannot :show, :admin_dashboard
    can :show, :member_dashboard
  end

end
