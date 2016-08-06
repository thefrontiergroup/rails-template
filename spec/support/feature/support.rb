# Include any general purpose helper functions in this file, that would be applicable for
# any project they were dropped into.
#
module Feature
  module Support

    def submit_form
      find('input[name="commit"]').click
    end

    # http://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
    def wait_for_ajax!
      Timeout.timeout(Capybara.default_wait_time) do
        loop until page.evaluate_script('jQuery.active').zero?
      end
    end

  end
end
