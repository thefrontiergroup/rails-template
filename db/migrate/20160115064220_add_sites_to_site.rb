class AddSitesToSite < ActiveRecord::Migration
  def change
    add_column :sites, :sites, :string
  end
end
