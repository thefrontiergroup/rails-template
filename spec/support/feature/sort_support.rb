module Feature
  module SortSupport

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
