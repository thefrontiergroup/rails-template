###
  Datepicker implementation

  Problem 1:
    We want to use the HTML5 date input, but not all browsers support it yet.

  Solution 1:
    2 scenarios:
      1) Desktop
          The only browser that currently supports the date input is Chrome.
          We decided to make the desktop experience the same across all desktop browsers.
          For this we use the Pikaday.js library.

      2) Mobile
          Mobile browsers support date inputs and have a native UI for
          displaying them; we want to make use of that.

  Problem 2:
    We want the user to see the local Australian format of DD/MM/YYYY in a datepicker field.
    Therefore, we changed the server's return value to serve this format.
    However, HTML5 date inputs require the value - the date - to be in RFC format (YYYY-MM-DD)
    to work.

  Solution 2:
    We use Modernizr to detect if we are on a Touch device and if the browser supports date inputs.
    If yes, we reformat the server's returned value to RFC and change the input type to date.
    If no, it will fall back to Pikaday.

###

transformDateToRFC = (dateInput) ->
  $currentDateInput = $(dateInput)
  currentDate = moment($currentDateInput.val(), "DD/MM/YYYY")
  $currentDateInput
    .val(currentDate.format("YYYY-MM-DD"))
    .attr(
      type: "date"
      placeholder: "DD/MM/YYYY"
    )

bindDatepickers = ($datePickers) ->
  defaultDatePickerArgs =
    format: 'DD/MM/YYYY'
    firstDay: 1 # 0: Sunday, 1: Monday, etc
    yearRange: 10 # Number of years either side the year select
  $datePickers.addClass('pikaday').pikaday(defaultDatePickerArgs)

$ ->
  $datePickers = $('input.date-picker')
  if Modernizr?.inputtypes.date and Modernizr.touch
    $datePickers.each -> transformDateToRFC(this)
  else
    bindDatepickers($datePickers)
