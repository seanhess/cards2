# an angularjs droppable directive
# <div droppable dropFile="onDropFile()" dropUrl="onDropUrl()">
# also sets "dragover" class when something is over the dom element

define (require) ->
  jquery = require 'jquery'
  droppable = ($parse) ->
    (scope, element, atts) ->

      dropFile = $parse atts.dropfile
      dropUrl = $parse atts.dropurl

      dom = element.get(0)
      timer = null

      cancel = (e) ->
        e?.preventDefault?()               # required by FF + Safari
        e.dataTransfer.dropEffect = 'copy' # tells the browser what drop effect is allowed here
        return false                       # required by IE

      onDragEnter = (e) ->
        cancel e

      onDragExit = (e) ->
        element.removeClass "dragover"
        cancel e

      onDragOver = (e) ->
        element.addClass "dragover"
        cancel e

      onDrop = (e) ->
        onDragExit e

        files = e.dataTransfer?.files ? []
        text = e.dataTransfer.getData "Text"

        if text? then dropUrl scope, {url: text}

        # I don't know what to do with files!

        # files.forEach (file) ->
        #   reader = new FileReader()
        #   reader.onload = (e) ->
        #     dropFile scope, {file: e.target.result}
        #   reader.readAsDataURL file

        # e.dataTransfer.types.forEach (type) ->
        #   console.log type, e.dataTransfer.getData(type)

      noop = (e) ->

      dom.addEventListener "dragenter", onDragEnter, false
      dom.addEventListener "dragover", onDragOver, false
      # dom.addEventListener "dragexit", onDragExit, false
      dom.addEventListener "dragleave", onDragExit, false

      dom.addEventListener "drop", onDrop, false
