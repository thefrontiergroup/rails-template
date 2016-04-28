class NumericInput < SimpleForm::Inputs::NumericInput

  def input(wrapper_options = nil)
    if numericality_validator.present?
      input_html_options[:min] ||= numericality_validator.options[:min]
      input_html_options[:max] ||= numericality_validator.options[:max]
    end

    super
  end

private

  def numericality_validator
    object.class.respond_to?(:validators) && object.class.validators_on(attribute_name).find do |validator|
      validator.is_a?(ActiveModel::Validations::NumericalityValidator)
    end
  end

end
