class Member::BaseController < ApplicationController
  before_action :authenticate_user!
  check_authorization

  layout "member/layout"
end
