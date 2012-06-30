

define (require) ->
  angular = require 'angular'
  require 'js/directives'
  require 'js/filters'
  require 'js/services'
  require 'js/controllers'

  routes = ($routeProvider) ->
    $routeProvider.when '/rooms/', {templateUrl: 'partials/rooms.html', controller: RoomsCtrl}
    $routeProvider.when '/rooms/:id', {templateUrl: 'partials/room.html', controller: RoomCtrl}

    $routeProvider.otherwise({redirectTo: '/rooms'})

  # Declare app level module which depends on filters, and services
  angular.module('myApp', ['myApp.filters', 'myApp.services', 'myApp.directives']).
    config ['$routeProvider', routes]
