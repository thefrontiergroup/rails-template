class Admin::MembersController < Admin::UsersController

protected

  def users_scope
    User.member
  end

  def redirect_path
    admin_members_path
  end

end
