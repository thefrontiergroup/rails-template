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

    # User.all
    scoped_users = user_scope

    if search_params[:email].present?
      scoped_users = scoped_users.email_search(search_params[:email])
    end

    if search_params[:post_code].present?
      scoped_users = scoped_users.in_post_code(search_params[:post_code])
    end

    if search_params[:site_ids].present?
      scoped_users = scoped_users.where(site_id: search_params[:site_ids])
    end

    if search_params[:state_id].present?
      scoped_users = scoped_users.in_state(search_params[:state_id])
    end

    if search_params[:rural].present?
      scoped_users = scoped_users.in_rural_area(search_params[:rural])
    end

    # Date.parse
    if search_params[:updated_from].present? && search_params[:updated_until].present?
      scoped_users = scoped_users.updated_at_between(Date.parse(search_params[:updated_from]), Date.parse(search_params[:updated_until]))
    end

    if search_params[:updated_from].present?
      scoped_users = scoped_users.updated_at_after(Date.parse(search_params[:updated_from]))
    end

    if search_params[:updated_until].present?
      scoped_users = scoped_users.updated_at_before(Date.parse(search_params[:updated_until]))
    end

    scoped_users
  end

end