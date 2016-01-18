class Admin::AdminsController < Admin::UsersController


  def user_role
    "admin"
  end

  def redirect_path
    admin_admins_path
  end

end
