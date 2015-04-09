if defined?(SeedHelper)
  SeedHelper.create_seed_task(:users) do

    [
      { email: 'admin@example.com', role: User.roles["admin"] },
      { email: 'member@example.com', role: User.roles["member"] },
    ].each do |user_attributes|
      SeedHelper.find_or_create_resource(User, user_attributes.merge(password: "password"))
    end

  end
end