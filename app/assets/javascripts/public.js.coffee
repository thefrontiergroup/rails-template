#= require _global

#= require semantic-ui

#= require_tree ./public

$(document).ready ->

    # Create sidebar and attach to menu open
    $('.ui.sidebar').sidebar('attach events', '.toc.item')
