if defined?(SeedHelper)
  SeedHelper.create_seed_task(:users) do

    User.roles.keys.each do |role_name|
      user_attributes = { email: "#{role_name}@example.com", role: User.roles[role_name] }
      SeedHelper.find_or_create_resource(User, user_attributes.merge(password: "password"))
    end

  end
end