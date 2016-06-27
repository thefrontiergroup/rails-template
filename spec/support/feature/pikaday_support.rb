module Feature
  module PikadaySupport
    def fill_in_pikaday_input(field_name, with:)
      find_field(field_name).click
      fill_in(field_name, with: with)
      # This causes each Pikaday input to be correctly set by triggering the change event
      page.execute_script("document.getElementsByTagName('body')[0].focus()")
      # This removes the focus from the datepicker following the change event.
      # This prevents issues where inputs will not be filled in after filling in a Pikaday input
      find_field(field_name).parent.click
    end
  end
end
