# Filters

interpolate = (version) ->
  (text) ->
    return String(text).replace(/\%VERSION\%/mg, version)

angular.module('myApp.filters', []).
  filter('interpolate', ['version', interpolate])
