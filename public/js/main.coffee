
require.config
  baseUrl: '../'

  shim:
    underscore: exports: '_'
    angular:
      exports: 'angular'
      deps: ['jquery']
    jquery: exports: 'jQuery'

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

define [], (require) ->

  $ = require 'jquery'
  angular = require 'angular'
  directives = require 'js/directives'
  filters = require 'js/filters'
  services = require 'js/services'
  {RoomsCtrl, RoomCtrl} = require 'js/controllers'

  routes = ($routeProvider) ->
    $routeProvider.when '/rooms/', {templateUrl: 'partials/rooms.html', controller: RoomsCtrl}
    $routeProvider.when '/rooms/:id', {templateUrl: 'partials/room.html', controller: RoomCtrl}
    $routeProvider.when '/stuff', {templateUrl: 'partials/stuff.html'}

    $routeProvider.otherwise({redirectTo: '/rooms'})

  # Declare app level module which depends on filters, and services
  angular.module('cards', ['cards.filters', 'cards.services', 'cards.directives']).
    config ['$routeProvider', routes]


