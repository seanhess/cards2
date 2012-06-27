# Directives

define (require) ->
  angular = require 'wrap!angular'
  require 'draggable'

  appVersion = (version) ->
    (scope, elm, attrs) ->
      elm.text(version)

  draggable = () ->
    (scope, element, atts) ->
      element.draggable()

  droppable = ($parse) ->
    (scope, element, atts) ->

      action = $parse atts.drop
      dom = element.get(0)
      timer = null

      onDragEnter = (e) ->
        e.preventDefault()

      onDragExit = (e) ->
        e?.preventDefault()
        element.removeClass "dragover"

      onOver = (e) ->
        e.preventDefault()
        element.addClass "dragover"
        clearTimeout timer
        timer = setTimeout onDragExit, 100

      onDrop = (e) ->
        e.preventDefault()
        files = e.dataTransfer.files
        count = files.length
        action scope, {files, file:files[0]}

      noop = (e) ->

      dom.addEventListener "dragenter", onDragEnter, false
      dom.addEventListener "dragover", onOver, false
      dom.addEventListener "drop", onDrop, false


  angular.module('myApp.directives', [])
    .directive('appVersion', appVersion)
    .directive('droppable', droppable)
    .directive('draggable', draggable)

