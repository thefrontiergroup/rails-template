if defined?(SeedHelper)
  SeedHelper.create_seed_task(:users) do

    def seed_user(role, additional_attributes={})
      primary_attributes = {email: "#{role}@example.com"}

      if User.exists?(primary_attributes)
        SeedHelper.resource_already_exists(primary_attributes[:email])
      else
        attributes = primary_attributes.merge({password: "password"})
                                       .merge(additional_attributes)
        SeedHelper.create_resource(FactoryGirl.build(:user, role, attributes))
      end
    end

    def email_for_role(role)
      "#{role}@example.com"
    end

    seed_user(:admin)
    seed_user(:member)

  end
end
