if defined?(SeedHelper)
  SeedHelper.create_seed_task(:states) do

    [
      ["ACT", "Australian Capital Territory"],
      ["NSW", "New South Wales"],
      ["NT", "Northern Territory"],
      ["QLD", "Queensland"],
      ["SA", "South Australia"],
      ["TAS", "Tasmania"],
      ["VIC", "Victoria"],
      ["WA", "Western Australia"],
    ].each do |abbreviation, name|

      state_attributes = { abbreviation: abbreviation, name: name }
      SeedHelper.find_or_create_resource(State, state_attributes)

    end

  end
end