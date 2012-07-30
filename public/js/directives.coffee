# Directives

define (require) ->
  angular = require 'angular'
  droppable = require 'js/directives/droppable'
  draggable = require 'js/directives/draggable'

  asdf = ($parse) ->
    (scope, element, atts) ->
      onMove = $parse atts.dragmove
      onEnd = $parse atts.dragend

      dom = element.get(0)
      dom.addEventListener "dragover", (e) ->
        # you can specify that you are
        # call e.preventDefault() to say you accept. (only by certain types though?)
        e.preventDefault()
        # console.log "DRAG OVER"
      dom.addEventListener "drop", (e) ->
        e.preventDefault()
        console.log "DROP", e.dataTransfer.getData("text/plain")



  appVersion = (version) ->
    (scope, elm, attrs) ->
      elm.text(version)

  angular.module('cards.directives', [])
    .directive('appVersion', appVersion)
    .directive('droppable', droppable)
    .directive('draggable', draggable)
    .directive('asdf', asdf)

