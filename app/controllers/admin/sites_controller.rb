class Admin::SitesController < Admin::BaseController

  def index
    authorize(Site)
    @site = Site.all
  end

  def new
    @site = Site.new
    authorize(@site)
    @site.build_address
  end

  def create
    @site = Site.new(site_params)
    authorize(@site)
    @site.save

    respond_with(@site, location: admin_sites_path)
  end

  def show
    authorize(@site)
    @site = Site.find(params[:id])
  end

  def edit
     @site = Site.find(params[:id])
     authorize(@site)
     @site.save

     respond_with(@site, location: admin_sites_path)
  end

  def update
    @site = Site.find(params[:id])

    if @site.update(site_params)
      respond_with(@site, location: admin_sites_path)
      authorize(@site)
    else
      render 'edit'
    end
  end

  def destroy

  end

private

  def site_params
    params.require(:site).permit(:name, :rural, address_attributes: [:line_1, :post_code, :state_id])
  end

end