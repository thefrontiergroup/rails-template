class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  layout "admin/layout"

protected

  # Sort by :id by default, so there is a consistent order even when no order has been
  # selected via the interface
  def default_sort_options
    {id: :desc}
  end

  def sort(collection)
    ModelSorter.sort(collection, params, default_sort_options)
  end
end