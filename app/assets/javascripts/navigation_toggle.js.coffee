defaults =
  breakpoint: 860

class NavigationToggle
  constructor: (@element, @options) ->
    @$element = $(@element)
    target = @$element.data('navigation-toggle-target')
    return false unless target
    @$target = $(target)

    @isNavigationOpen = false
    @requiresModal = @$element.data('requires-modal')
    @settings = $.extend({}, defaults, @options)
    @init()

    return @element

  init: ->
    @_attachToggleActions()
    if @requiresModal
      @$modalFadeScreen = $('#js-fade-screen')
      @_initResizeListener()

  _attachToggleActions: ->
    @$element.on 'click touchstart', (event) =>
      event.preventDefault()
      @_toggleNavigation()

  _initResizeListener: ->
    @ticking = false
    @lastWindowWidth = 0
    $(window).resize => @._onResize()

  # callback for resize event - keeps track of window width
  _onResize: ->
    @lastWindowWidth = $(window).width()
    @_requestTick()

  # calls requestAnimationFrame (rAF), if it's not already been done
  _requestTick: ->
    unless @ticking
      # More information: http://www.html5rocks.com/en/tutorials/speed/animations/
      requestAnimationFrame(@_toggleAllowTransition)
      @ticking = true

  _bindCloseNavigation: ($navigation, $opener) ->
    @$modalFadeScreen.on 'click touchstart', (event) =>
      $opener.removeClass('expanded')
      @_toggleNavigation(false)

  _toggleExpandNavigation: ($navigation, toggle) ->
    if @requiresModal
      $('body').toggleClass('has-modal', toggle)

    $navigation
      .toggleClass('is-collapsed', !toggle)
      .toggleClass('is-expanded', toggle)
      .attr('aria-expanded', toggle)

  _toggleNavigation: (state) =>
    state = !@$target.hasClass('is-expanded') unless state?

    @$element.toggleClass('expanded', state)
    if state
      @_showNavigation(@$target)
    else
      @_hideNavigation(@$target)

  _toggleAllowTransition: =>
    if @lastWindowWidth > @settings.breakpoint
      @$target.removeClass('transitionable')
      # When the device transitions from a small screen to a larger screen, we ensure that any navigations
      # are closed. When @requiresModal is true a darkened overlay will be present on the screen. If we
      # don't ensure that the expandedNavigation is closed, the darkened overlay will remain when the
      # screen size changes.
      @_toggleExpandNavigation(@$target, false) if @isNavigationOpen
    else
      @$target.addClass('transitionable')
    # allow further rAFs to be called
    @ticking = false

  _showNavigation: ($navigation) ->
    @isNavigationOpen = true
    if @requiresModal
      @_bindCloseNavigation($navigation, @$element)
    @_toggleExpandNavigation($navigation, true)
    # set focus on the first link to make keyboard navigation easier
    selectFirstLink = -> $navigation.find('a').first().get(0).focus()
    setTimeout(selectFirstLink, 50)

  _hideNavigation: ($navigation) ->
    @isNavigationOpen = false
    if @requiresModal
      @$modalFadeScreen.unbind('click touchstart')
    @_toggleExpandNavigation($navigation, false)

$.fn['navigationToggle'] = (options) ->
  return this.each ->
    unless $.data(this, 'navigationToggle')
      $.data(this, 'navigationToggle', new NavigationToggle(this, options))

$ ->

  $('.js-nav-toggle').navigationToggle()
