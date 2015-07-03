module AttributesComparisonSupport

  def expect_attributes_to_match(target_object, attributes)
    sanitized_attributes = attributes.clone
    # There is no point comparing files, at best we can assert that there is a file but
    # unless we compare the contents of the Files (slow).
    file_attributes = sanitized_attributes.select(&file_lambda)
    sanitized_attributes.reject!(&file_lambda)

    expect(target_object).to have_attributes(sanitized_attributes)
    file_attributes.keys.each do |file_attribute|
      expect(target_object.send(file_attribute).file).to be_present
    end
  end

private

  def file_lambda
    lambda {|name, value| value.is_a?(File) || value.is_a?(Rack::Test::UploadedFile) }
  end

end