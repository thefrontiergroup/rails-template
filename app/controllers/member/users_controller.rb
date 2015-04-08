class Member::UsersController < Member::BaseController

  def edit
    @user = find_user
    authorize(@user, :update?)
  end

  def update
    @user = find_user
    authorize(@user, :update?)

    if @user.update_attributes(user_form_attributes(@user))
      flash[:notice] = "User #{@user} successfully updated"
      # When we change the email or password Warden will not be able to recognize the session
      # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
      sign_in(@user, bypass: true)
      redirect_to(member_dashboard_index_path)
    else
      render :edit
    end
  end

private

  def find_user
    User.find(params[:id])
  end

  def user_form_attributes(user)
    params.require(:user).permit(policy(user).permitted_attributes)
  end

end