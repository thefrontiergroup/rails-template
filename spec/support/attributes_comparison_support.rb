module AttributesComparisonSupport

  def expect_attributes_to_match(target_object, attributes)
    sanitized_attributes = attributes.clone
    # There is no point comparing files, unless we compare the contents of the Files. However
    # that comparison will be slow and the cost is higher than the benefit.
    file_attributes, sanitized_attributes = sanitized_attributes.partition(&file_lambda)
    # Times are also hard to compare, as they get out by ms
    time_attributes, sanitized_attributes = sanitized_attributes.partition(&time_lambda)
    # Ignore any nested attributes - these should be tested specifically if required.
    sanitized_attributes.reject! {|key, value| key =~ /_attributes/}

    expect(target_object).to have_attributes(Hash[*sanitized_attributes.flatten])

    expect_files_to_match(target_object, file_attributes)
    expect_times_to_match(target_object, time_attributes)
  end

private

  def expect_files_to_match(target_object, file_attributes)
    file_attributes.each do |file_attribute_name, value|
      expect(target_object.send(file_attribute_name).file).to be_present
    end
  end

  def expect_times_to_match(target_object, time_attributes)
    time_attributes.each do |time_attribute_name, value|
      expect(target_object.send(time_attribute_name).to_i).to eq(value.to_i)
    end
  end

  def file_lambda
    lambda {|name, value| value.is_a?(File) || value.is_a?(Rack::Test::UploadedFile) }
  end

  def time_lambda
    lambda {|name, value| value.is_a?(DateTime) || value.is_a?(Time) }
  end

end