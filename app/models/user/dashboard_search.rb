class User::DashboardSearch

  attr_reader :search_params, :user_scope

  # User::DashboardSearch.new(User.all, {email: "jordan@example.com"}).users
  #
  # user_scope will be a scoped User collection (EG: User.all)
  # search_params may have:
  #   {
  #     email: "jordan@example.com",
  #     site_ids: [1, 2, 3],
  #     updated_from: "19/05/1988",
  #     updated_until: "19/05/1988",
  #     state_id: 1,
  #     post_code: "1234",
  #     is_rural: "true"
  #   }
  def initialize(user_scope, search_params)
    @user_scope    = user_scope
    @search_params = search_params
  end

  def users
    # Based on the filters and values specified in the search_params hash, scope the existing
    # user_scope passed through using the scopes you've created in your User model

    scoped_users = user_scope

    if search_params[:email].present?
      scoped_users = scoped_users.email_search(search_params[:email])
    end

    scoped_users
  end

end