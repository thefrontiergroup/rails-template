class Admin::UsersController < Admin::BaseController

  def index
    authorize(User)
    @users = sort(policy_scope(User.member)).page(params[:page])
  end

  def index_admins
    authorize(User)
    @users = sort(policy_scope(User.admin)).page(params[:page])
    render :index
  end

  def new
    @user = User.new
    authorize(@user)
  end

  def create
    @user = User.new
    authorize(@user)
    @user.update_attributes(user_form_attributes(@user))

    respond_with(@user, location: admin_users_path)
  end

  def edit
    @user = find_user
    authorize(@user)
  end

  def update
    @user = find_user
    authorize(@user)

    if @user.update_attributes(user_form_attributes(@user))
      flash[:notice] = "User #{@user} successfully updated"
    end
    respond_with(@user, location: admin_users_path)
  end

  def destroy
    @user = find_user
    authorize(@user)
    @user.destroy
    redirect_to(admin_users_path, notice: "'#{@user}' deleted")
  end

private

  def find_user
    User.find(params[:id])
  end

  def sort(collection)
    ModelSorter.sort(collection, params)
  end

  def user_form_attributes(user)
    params.require(:user).permit(policy(user).permitted_attributes).tap do |attributes|
      attributes[:user].delete(:password) if attributes[:user].present? && attributes[:user][:password].blank?
    end
  end

end