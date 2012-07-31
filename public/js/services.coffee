# Services

define (require) ->
  angular = require 'angular'
  Room = require 'js/services/Room'
  urls = require 'js/services/urls'

  angular.module('cards.services', [])
    .value('version', '0.1')
    .factory('Room', Room)
    .factory('urls', urls)


