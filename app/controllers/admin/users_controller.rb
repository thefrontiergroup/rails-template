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
    @user = User.new(user_form_attributes)
    authorize(@user, :create?)
    @user.save

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

private

  def find_user
    User.find(params[:id])
  end

  def user_form_attributes
    params.permit(user: [:email, :role, :password])[:user].tap do |attributes|
      attributes.delete(:password) if attributes[:password].blank?
    end
  end

end