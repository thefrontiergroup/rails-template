# Timepicker inputs
#
# The TimePickerInput is paired with 'jquery-timepicker-rails' to provide an easy selection
# of a time. EG: "9:30 AM".
#
# The controller that receives this data will need to parse this time in some meaningful way.
#
# Default usage:
#   = f.input :start_time, as: :time_picker
#
# Semantic UI usage:
#   = f.input :start_time do
#     .ui.left.icon.input
#       %i.clock.icon
#       = f.input_field :start_time, as: :time_picker

class TimePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:class] << "time-picker"
    input_html_options[:autocomplete] = "off"

    if object.respond_to?(attribute_name) && object.send(attribute_name).present?
      input_html_options[:value] = I18n.l(object[attribute_name], format: :concise)
    end

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.text_field(attribute_name, merged_input_options)
  end
end
