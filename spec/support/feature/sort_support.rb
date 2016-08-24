module Feature
  module SortSupport

    # Assert that a link behaves like a sorting link by first asserting that clicking it once
    # will set an order, then clicking it a second time will reverse that order.
    #
    # Basic usage:
    #   expect_heading_to_sort_objects("Name", [alpha, bravo])
    #
    # When the page has sorted by the given order already (Note: This will assert that the
    # order of the objects is set to [alpha, bravo] before clicking the links:
    #   expect_heading_to_sort_objects("Name", [alpha, bravo], sorted_by_default: true)
    #
    # When the objects cannot be identified by the output of their #to_s you can pass a block
    # that will receive the object to identify. The block should return the attribute that
    # can be used to identify the object on the page:
    #   expect_heading_to_sort_objects("Name", [alpha, bravo]) {|user| user.email}
    #
    # When the link cannot just be clicked. EG: There are multiple links with the same text,
    # you can pass a block in to scope the click by:
    #
    #   click_the_user_link = -> { within(".my_dope_class") { click_link("Name")} }
    #   expect_heading_to_sort_objects(click_the_user_link, [alpha, bravo])
    #
    def expect_heading_to_sort_objects(link_or_lambda, objects, sorted_by_default: false, &identification_method)
      if sorted_by_default
        expect_objects_to_be_ordered(*objects, &identification_method)
        # If the objects are sorted on this field by default, the first time the link is
        # clicked the objects will be in the reverse order
        objects = objects.reverse
      end

      # Clicking the sort link should reverse the order of the objects on the page.
      [objects, objects.reverse].each do |objects_ordered_as_expected|
        if link_or_lambda.is_a?(String)
          click_link(link_or_lambda)
        elsif link_or_lambda.respond_to?(:call)
          link_or_lambda.call
        else
          raise(ArgumentError, "Unknown link provided #{link_or_lambda}, must be either a string or a lambda")
        end
        expect_objects_to_be_ordered(*objects_ordered_as_expected, &identification_method)
      end
    end

    # Usage:
    #
    # Without a block to identify the records it will default to #to_s:
    #   expect_objects_to_be_ordered(first_object, second_object, ..., nth_object)
    #
    # With a block to identify the records:
    #   expect_objects_to_be_ordered(first_object, second_object) {|object| object.name}
    #
    def expect_objects_to_be_ordered(*objects, &identification_method)
      objects.each_with_index do |object, index|
        within("tbody tr:nth-child(#{index + 1})") do
          expected_text = block_given? ? identification_method.call(object) : object.to_s

          expect(page).to have_text(expected_text)
        end
      end
    end

  end
end
