module Feature
  module PikadaySupport
    def fill_in_pikaday_input(field_name, with:)
      find_field(field_name).click
      fill_in(field_name, with: with)
      # This causes each Pikaday input to be correctly set
      page.execute_script("$('body').focus()")
      find_field(field_name).parent.click
    end
  end
end
