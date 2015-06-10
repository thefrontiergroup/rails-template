class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  layout "admin/layout"

protected

  def sort(collection)
    # Sort by :id by default, so there is a consistent order even when no order has been
    # selected via the interface
    ModelSorter.sort(collection, params, {id: :desc})
  end
end