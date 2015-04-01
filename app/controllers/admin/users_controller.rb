class Admin::UsersController < Admin::BaseController

  def index
    authorize(User, :index?)
    @users = User.all.page(params[:page])
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

end