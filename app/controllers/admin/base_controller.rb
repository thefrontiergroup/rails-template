class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_can_access_admin_section
  check_authorization

  layout "admin/layout"

private

  def ensure_user_can_access_admin_section
    authorize!(:show, :admin_controllers)
  end

end
