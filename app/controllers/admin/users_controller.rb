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
    @user = User.new(new_user_attributes)
    @user.save if authorize(@user, :create?)

    respond_with(@user, location: admin_users_path)
  end

  def edit

  end

  def update

  end

private

  def new_user_attributes
    params.permit(user: [:email, :role, :password])[:user]
  end

end