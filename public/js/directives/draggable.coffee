
define (require) ->
  require 'draggable'

  draggable = ($parse) ->
    (scope, element, atts) ->
      dragType = atts.draggable
      onMove = $parse atts.dragmove
      onEnd = $parse atts.dragend
      onClick = $parse atts.dragclick
      onStart = $parse atts.dragstart
      getData = $parse atts.dragdata


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

