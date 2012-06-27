
require.config
  baseUrl: '../'
  paths:
    # requirejs plugins
    text: 'lib/requirejs/text'
    wrap: 'lib/requirejs/wrap'

    # libs
    angular: 'lib/angular/angular'
    modernizr: 'lib/Modernizr'
    jquery: 'lib/jquery'
    underscore: 'lib/underscore'
    socketio: '/socket.io/socket.io'

  wrapJS:

    angular:
      attach: 'angular'

    underscore:
      attach: '_'

    modernizr:
      attach: 'Modernizr'

    socketio:
      attach: 'io'

require ['js/app'], (app) ->
  console.log "DONE"


