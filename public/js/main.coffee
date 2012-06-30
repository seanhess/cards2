
require.config
  baseUrl: '../'

  shim:
    underscore: exports: '_'
    angular: exports: 'angular'

  paths:
    # requirejs plugins
    text: 'lib/requirejs/text'
    wrap: 'lib/requirejs/wrap'

    # libs
    underscore: 'lib/underscore'
    angular: 'lib/angular/angular'
    modernizr: 'lib/Modernizr'
    jquery: 'lib/jquery'
    socketio: '/socket.io/socket.io'
    fjs: 'lib/fjs'

    # jquery plugins
    draggable: 'lib/jquery.draggable'

# require jquery globally
require ['jquery', 'js/app', 'jquery'], ($, app) ->
  console.log "DONE"


