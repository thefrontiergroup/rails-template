class Admin::AdminsController < Admin::UsersController

protected

  def users_scope
    User.admin
  end

  def redirect_path
    admin_admins_path
  end

end
