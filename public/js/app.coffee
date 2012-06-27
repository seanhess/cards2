

define (require) ->
  angular = require 'wrap!angular'
  require 'js/directives'
  require 'js/filters'
  require 'js/services'
  require 'js/controllers'

  routes = ($routeProvider) ->
    $routeProvider.when('/view1', {templateUrl: 'partials/partial1.html', controller: MyCtrl1})
    $routeProvider.when('/view2', {templateUrl: 'partials/partial2.html', controller: MyCtrl2})
    $routeProvider.otherwise({redirectTo: '/view1'})

  # Declare app level module which depends on filters, and services
  angular.module('myApp', ['myApp.filters', 'myApp.services', 'myApp.directives']).
    config ['$routeProvider', routes]
