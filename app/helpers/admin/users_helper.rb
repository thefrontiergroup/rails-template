module Admin::UsersHelper

   def edit_path_for_user(user)
    case user.role
    when "admin"
      edit_admin_admin_path(user)
    when "member"
      edit_admin_member_path(user)
    else
      raise(ArgumentError, "Trying to generate edit path for unknown role: #{user.role}")
    end
  end

  def delete_path_for_user(user)
    case user.role
    when "admin"
      admin_admin_path(user)
    when "member"
      admin_member_path(user)
    else
      raise(ArgumentError, "Trying to generate delete path for unknown role: #{user.role}")
    end
  end

end
