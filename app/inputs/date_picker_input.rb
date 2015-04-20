# Datepicker inputs
#
# This returns a simple text input, that will get picked up by `datepicker.js.coffee`.
# JS will then either attach Pikaday (desktop) or change the input type to 'date' (mobile).
#
# Default usage:
#   = f.input :deadline, as: :date_picker

class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:class] << "date-picker"
    input_html_options[:autocomplete] = "off"

    if object.send(attribute_name)
      input_html_options[:value] = object.send(attribute_name).strftime("%d/%m/%Y")
    end

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.text_field(attribute_name, merged_input_options)
  end
end
