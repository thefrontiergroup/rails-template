class Admin::UsersController < Admin::BaseController

  def index
    authorize(User)
    @ransack_query = User.ransack(params[:q])
    @users = users_scope.merge(@ransack_query.result)
                        .page(params[:page])
  end

  def new
    @user = users_scope.new
    authorize(@user)
  end

  def create
    @user = users_scope.new
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

protected

  def users_scope
    raise(NotImplementedError, "#users_scope must be implemented. It should return a collection of Users scoped as the inheriting controller requires")
  end

  def redirect_path
    raise(NotImplementedError, "#redirect_path must be implemented. It should return a path to redirect to following a successful #create, #update, or #destroy")
  end

  def permitted_attributes
    [:email, :password]
  end

private

  def find_user
    users_scope.find(params[:id])
  end

  def user_form_attributes(user)
    params.require(:user).permit(permitted_attributes).tap do |attributes|
      attributes[:user].delete(:password) if attributes[:user].present? && attributes[:user][:password].blank?
    end
  end

end
