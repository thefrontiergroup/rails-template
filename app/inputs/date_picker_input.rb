# Datepicker inputs
#
# This returns a simple text input that will get picked up by `datepicker.js.coffee`.
# JS will then attach Pikaday.
#
# Default usage:
#   = f.input :deadline, as: :date_picker
#
# Semantic UI usage:
#   = f.input :deadline do
#     .ui.left.icon.input
#       %i.calendar.icon
#       = f.input_field :deadline, as: :date_picker

class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:class] << "date-picker"
    input_html_options[:autocomplete] = "off"

    if object.respond_to?(attribute_name) && object.send(attribute_name).present?
      input_html_options[:value] = I18n.l(object.send(attribute_name).to_date, format: :concise)
    end

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.text_field(attribute_name, merged_input_options)
  end
end
