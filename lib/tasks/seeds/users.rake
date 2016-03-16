if defined?(SeedHelper)
  SeedHelper.create_seed_task(:users) do

    def seed_user(role, additional_attributes={})
      primary_attributes = {email: "#{role}@example.com"}

      SeedHelper.find_or_create_resource(User, primary_attributes) do
        attributes = primary_attributes.merge({password: "password"})
                                       .merge(additional_attributes)
        FactoryGirl.build(:user, role, attributes)
      end
    end

    seed_user(:admin)
    seed_user(:member)

  end
end
