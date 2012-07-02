# Directives

define (require) ->
  angular = require 'angular'
  droppable = require 'js/directives/droppable'
  draggable = require 'js/directives/draggable'

  appVersion = (version) ->
    (scope, elm, attrs) ->
      elm.text(version)

  angular.module('cards.directives', [])
    .directive('appVersion', appVersion)
    .directive('droppable', droppable)
    .directive('draggable', draggable)

