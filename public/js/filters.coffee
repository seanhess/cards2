# Filters

define (require) ->
  angular = require 'angular'

  interpolate = (version) ->
    (text) ->
      return String(text).replace(/\%VERSION\%/mg, version)

  angular.module('cards.filters', []).
    filter('interpolate', interpolate)
