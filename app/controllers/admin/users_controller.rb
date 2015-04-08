class Admin::UsersController < Admin::BaseController

  def index
    authorize(User, :index?)
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
    authorize(@user, :create?)
  end

  def create
    @user = User.new
    authorize(@user, :create?)
    @user.update_attributes(user_form_attributes)

    respond_with(@user, location: admin_users_path)
  end

  def edit
    @user = find_user
    authorize(@user, :update?)
  end

  def update
    @user = find_user
    authorize(@user, :update?)

    if @user.update_attributes(user_form_attributes)
      flash[:notice] = "User #{@user} successfully updated"
    end
    respond_with(@user, location: admin_users_path)
  end

  def destroy
    @user = find_user
    authorize(@user, :destroy?)
    @user.destroy
    redirect_to(admin_users_path, notice: "'#{@user}' deleted")
  end

private

  def find_user
    User.find(params[:id])
  end

  def user_form_attributes
    params.require(:user).permit(:email, :role, :password).tap do |attributes|
      attributes[:user].delete(:password) if attributes[:user].present? && attributes[:user][:password].blank?
    end
  end

end