###
  Datepicker implementation

  Problem:
    We want to use the HTML5 date input, but not all browsers support it yet.
    And, the browsers that do support date inputs all have a different implementation.

  Solution:
    The only browser that currently decently supports the date input is Chrome.
    We decided to make the experience the same across all browsers.
    For this we use the Pikaday.js library.

###

bindDatepickers = (datePickerInput) ->
  defaultDatePickerArgs =
    format: 'DD/MM/YYYY'
    firstDay: 1 # 0: Sunday, 1: Monday, etc
    yearRange: 10 # Number of years either side the year select

  # Use event delegation to assign pikaday to any `date-picker` input,
  # including ones that get added to the DOM later on.
  $('form')
    .find(datePickerInput)
      .removeClass('date_picker')
      .end()
    .on('focus', datePickerInput, ->
      $(this)
        .addClass('pikaday')
        .pikaday(defaultDatePickerArgs)
    )

  # Manually assign pikaday to any inputs that are not in a form, if any
  if ($pristineDatepickerInputs = $('input.date_picker')).length
    $pristineDatepickerInputs.addClass('pikaday').pikaday(defaultDatePickerArgs)

$(document).ready ->
  bindDatepickers('input.date-picker')
