class AdminAbility < BaseAbility

  def initialize(user)
    can :manage, :all
    cannot :show, :member_dashboard
  end

end
