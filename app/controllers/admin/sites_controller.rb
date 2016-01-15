class Admin::SitesController < Admin::BaseController

  def index
    authorize(Site)
  end

  def new
  end

  def edit
  end


end