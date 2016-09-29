#= require _global

#= require semantic-ui
#= require jquery.timepicker.js
#= require_tree ./admin

$(document).ready ->
  # create sidebar and attach to menu open
  $('.ui.sidebar').sidebar('attach events', '.sidebar-toggle')

  $('.message .close').on 'click', ->
    $(this).closest('.message').transition('fade')
