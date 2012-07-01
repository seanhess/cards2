
define (require) ->

  require 'draggable'

  draggable = ($parse) ->
    (scope, element, atts) ->
      onMove = $parse atts.dragmove
      onEnd = $parse atts.dragend

      element.draggable()

      element.bind "dragmove", (e, {dx, dy}) ->
        scope.$apply ->
          onMove scope, {dx, dy, element}

      element.bind "dragend", ->
        position = element.position()
        scope.$apply ->
          onEnd scope, {position}
