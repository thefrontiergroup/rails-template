class DeviseCustomisations::SessionsController < Devise::SessionsController

  after_action :remove_notice, only: [:create, :destroy]

private

  def remove_notice
    flash.clear[:notice]
  end

end
