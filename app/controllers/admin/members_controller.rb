class Admin::MembersController < Admin::UsersController

  def user_role
    "member"
  end

  def redirect_path
    admin_members_path
  end

end
