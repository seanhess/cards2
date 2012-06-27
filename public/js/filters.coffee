# Filters

define (require) ->
  angular = require 'wrap!angular'

  interpolate = (version) ->
    (text) ->
      return String(text).replace(/\%VERSION\%/mg, version)

  angular.module('myApp.filters', []).
    filter('interpolate', interpolate)
