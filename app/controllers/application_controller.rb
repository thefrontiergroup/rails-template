class ApplicationController < ActionController::Base
  include Pundit
  respond_to :html
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected

  # Provided by Devise
  def after_sign_in_path_for(resource)
    user_policy = UserPolicy.new(resource, resource)
    if user_policy.admin_dashboard?
      admin_dashboard_index_path
    elsif user_policy.member_dashboard?
      member_dashboard_index_path
    else
      root_path
    end
  end

private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
