# Directives


define (require) ->
  angular = require 'wrap!angular'

  appVersion = (version) ->
    (scope, elm, attrs) ->
      elm.text(version)

  angular.module('myApp.directives', []).
    directive('appVersion', ['version', appVersion])
