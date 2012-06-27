
jQuery.fn.draggable = ->
  element = el = this
  startDragX = startDragY = 0
  startPosition = null
  startTime = null

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

    startTime = new Date().getTime()

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
    startPosition.left += changeX
    startPosition.top += changeY
    el.css startPosition

    el.trigger("dragmove", changeX, changeY)

    startDragX = x
    startDragY = y

  stop = ->
    console.log "STOP"
    # dropTarget = Droppable._droppableOnDragEnd(this, this.x, this.y, this.width, this.height)

    # el.trigger "dragend", dropTarget

    dragtime = new Date().getTime() - startTime

    if (dragtime < 130)
      trigger("dragclick")

    $(window)
      .unbind("mousemove touchmove", move)
      .unbind("mousemove mouseup mouseleave touchend touchcancel", stop)

  # start it!
  enable()

  return this



