class AbilityLocator

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def get_ability
    if user.present?
      ability_for_user
    else
      BaseAbility.new(user)
    end
  end

private

  def ability_for_user
    if user.admin?
      AdminAbility.new(user)
    elsif user.member?
      MemberAbility.new(user)
    else
      raise(ArgumentError, "No ability for user with role: #{user.role}")
    end
  end

end
