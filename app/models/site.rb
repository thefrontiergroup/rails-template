class Site < ActiveRecord::Base

  scope :named, -> (site_name) { where("sites.name ILIKE ?", "%#{site_name}%") }

end
