$ ->
  # In the 'Pages' sidebar, when a nav-toggle element is clicked, any other nav-toggle element
  # on the same layer will get an updated state, too.
  $('.sidebar-pages').on 'click touchstart', '.js-nav-toggle', ->
    $(this).siblings('.js-nav-toggle').toggleClass('expanded')
