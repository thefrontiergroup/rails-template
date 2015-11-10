class Admin::UsersController < Admin::BaseController

  def index
    authorize(User)
    @users = sort(policy_scope(User.public_send(user_role))).page(params[:page])
  end

  def new
    @user = User.new
    authorize(@user)
  end

  def create
    @user = User.new
    @user.role = user_role
    authorize(@user)
    @user.update_attributes(user_form_attributes(@user))

    respond_with(@user, location: redirect_path)
  end

  def edit
    @user = find_user
    authorize(@user)
  end

  def update
    @user = find_user
    authorize(@user)
    @user.update_attributes(user_form_attributes(@user))

    respond_with(@user, location: redirect_path)
  end

  def destroy
    @user = find_user
    authorize(@user)
    @user.destroy
    redirect_to(redirect_path, notice: "'#{@user}' deleted")
  end

private
  def user_role
    "user"
  end

  def redirect_path
    admin_users_path
  end

  def find_user
    User.find(params[:id])
  end

  def user_form_attributes(user)
    params.require(:user).permit(policy(user).permitted_attributes).tap do |attributes|
      attributes[:user].delete(:password) if attributes[:user].present? && attributes[:user][:password].blank?
    end
  end

end