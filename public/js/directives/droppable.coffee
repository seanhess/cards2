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

      dropData = $parse atts.dropdata
      dropUrl = $parse atts.dropurl
      dragTypes = atts.droppable?.split /\s/

      element.droppable
        dragTypes: dragTypes
        onDropUrl: (url) -> dropUrl scope, {url}
        onDropData: (data) ->
          console.log "DROP DATA", data
          dropData scope, {data}

