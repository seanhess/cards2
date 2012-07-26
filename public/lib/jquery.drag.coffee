
jQuery.fn.draggable = (options) ->
  options ?= {}
  options.shouldMove ?= false
  options.dragClickTolerance ?= 10

  element = el = this
  startDragX = startDragY = 0
  startPosition = null
  position = null

  # dom = this.get(0)
  # dom.addEventListener "dragstart", (e) ->

  if options.shouldMove
    # requires position absolute
    el.css position: 'absolute'


  dragStart = (e) ->
    console.log "DRAG START"
    e.preventDefault()
    e.dataTransfer?.setData("text/plain", "wooooot")
    el.css 'pointer-events', 'none'

  enable = el.draggableEnable = ->
    el.bind "mousedown touchstart", start
    el.bind "dragstart", dragStart

  disable = el.draggableDisable = ->
    el.unbind "mousedown touchstart", start
    el.unbind "dragstart", dragStart

  start = (e) ->
    if (e.originalEvent) then e = e.originalEvent
    if (e.type is 'mousedown' and e.which != 1) then return

    # e.preventDefault() # PREVENT DEFAULT HERE - stops dragstart from firing
    # this will get weird with touch?
    # don't trigger a dragstart. it gets triggered by the browser when you start moving
    # el.trigger "dragstart", e
    el.addClass "dragging"

    startPosition = el.position()
    position = {left: startPosition.left, top: startPosition.top}

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


    hit = document.elementFromPoint(x, y)

    changeX = x - startDragX
    changeY = y - startDragY

    # should I do this automatically?
    position.left += changeX
    position.top += changeY

    if options.shouldMove
      el.css position

    el.trigger "dragmove", {dx:changeX, dy:changeY}

    startDragX = x
    startDragY = y

  squareDistance = ->
    Math.abs(startPosition.left - position.left) + Math.abs(startPosition.top - position.top)

  stop = (e) ->
    el.removeClass "dragging"
    el.trigger "dragend"
    el.css 'pointer-events', 'auto'

    # e.dataTransfer?.setData("text/plain", "wooooot")

    if squareDistance() < options.dragClickTolerance
      el.trigger "dragclick"

    $(window)
      .unbind("mousemove touchmove", move)
      .unbind("mousemove mouseup mouseleave touchend touchcancel", stop)

  # start it!
  enable()

  return this



