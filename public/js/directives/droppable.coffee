# an angularjs droppable directive
# <div droppable dropFile="onDropFile()" dropUrl="onDropUrl()">
# also sets "dragover" class when something is over the dom element

# NATIVE droppable
# native-droppable
# nativedroppabel

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
        e.originalEvent.dataTransfer.dropEffect = 'copy' # tells the browser what drop effect is allowed here
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
        dataTransfer = e.originalEvent.dataTransfer

        ## DRAG FILE
        files = dataTransfer.files ? []

        ## DRAG URL
        # mac chrome canary: text/html, text-uri-list
        # safari: text, text-uri-list
        url = dataTransfer.getData "text/uri-list"
        if url? then dropUrl scope, {url}


        # I don't know what to do with files!
        # FileReader doesn't work in safari!! Oh well, URLs work, and I'd rather do that anyway :)
        # Array.prototype.forEach.call files, (file) ->
        #   reader = new FileReader()
        #   reader.onload = (e) ->
        #     dropFile scope, {file: e.target.result}
        #   reader.readAsDataURL file
        #   reader.readAsDataURL file
        #   reader.readAsText file
        #   reader.readAsBinaryString file
        #   reader.readAsArrayBuffer file

        # dataTransfer.types.forEach (type) ->
        #   console.log type, dataTransfer.getData(type)

      noop = (e) ->

      # dom.addEventListener "dragover", onDragOver, false
      element.bind 'dragenter', onDragEnter
      element.bind 'dragover', onDragOver

      # dom.addEventListener "dragexit", onDragExit, false
      element.bind "dragleave", onDragExit

      element.bind "drop", onDrop
