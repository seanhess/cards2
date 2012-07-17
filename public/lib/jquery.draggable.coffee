
jQuery.fn.draggable = (options) ->
  options ?= {}
  options.shouldMove ?= false
  options.dragClickTolerance ?= 10

  element = el = this
  startDragX = startDragY = 0
  startPosition = null
  position = null

  if options.shouldMove
    # requires position absolute
    element.css position: 'absolute'

  enable = el.draggableEnable = ->
    el.bind "mousedown touchstart", start

  disable = el.draggableDisable = ->
    el.unbind "mousedown touchstart", start

  start = (e) ->
    if (e.originalEvent) then e = e.originalEvent
    if (e.type is 'mousedown' and e.which != 1) then return
    e.preventDefault()

    startPosition = el.position()
    position = {left: startPosition.left, top: startPosition.top}

    el.trigger "dragstart", e

    if (e.targetTouches)
      startDragX = e.targetTouches[0].pageX
      startDragY = e.targetTouches[0].pageY

      $(window)
        .bind('touchmove', move)
        .bind('touchend touchcancel', stop)

    else
      startDragX = e.clientX
      startDragY = e.clientY
      
      $(window)
        .mousemove(move)
        .mouseup(stop)
        .mouseleave(stop)

  move = (e) ->
    if e.originalEvent then e = e.originalEvent
    x = y = changeX = changeY = null

    if e.targetTouches
      x = e.targetTouches[0].pageX
      y = e.targetTouches[0].pageY
    else
      x = e.clientX
      y = e.clientY

    changeX = x - startDragX
    changeY = y - startDragY


    # should I do this automatically?
    position.left += changeX
    position.top += changeY

    el.addClass "dragging"

    if options.shouldMove
      el.css position

    el.trigger "dragmove", {dx:changeX, dy:changeY}

    startDragX = x
    startDragY = y

  squareDistance = ->
    Math.abs(startPosition.left - position.left) + Math.abs(startPosition.top - position.top)

  stop = ->
    el.removeClass "dragging"

    if squareDistance() < options.dragClickTolerance
      el.trigger "dragclick"
    else
      el.trigger "dragend"

    $(window)
      .unbind("mousemove touchmove", move)
      .unbind("mousemove mouseup mouseleave touchend touchcancel", stop)

  # start it!
  enable()

  return this



