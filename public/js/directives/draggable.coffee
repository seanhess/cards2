
define (require) ->
  require 'draggable'

  draggable = ($parse) ->
    priority: 50
    link: (scope, element, atts) ->
      atts.$observe "droppable", (value) ->
        onMove = $parse atts.dragmove
        onEnd = $parse atts.dragend
        onClick = $parse atts.dragclick
        onStart = $parse atts.dragstart
        getData = $parse atts.dragdata
        dragType = atts.draggable

        element.draggable
          dragType: dragType
          dragData: getData scope

        element.bind "dragstart", (e) ->
          scope.$apply ->
            onStart scope

        element.bind "dragmove", (e, {dx, dy}) ->
          scope.$apply ->
            onMove scope, {dx, dy, element}

        element.bind "dragend", ->
          position = element.position()
          scope.$apply ->
            onEnd scope, {position}

        element.bind "dragclick", ->
          scope.$apply ->
            onClick scope

