class AdminAbility < BaseAbility

  def initialize(user)
    can :manage, :all
    cannot :show, :user_dashboard
  end

end
