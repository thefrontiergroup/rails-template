class AddSitesNamesToSite < ActiveRecord::Migration
  def change
    add_column :sites, :sites_names, :string
  end
end
