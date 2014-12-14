'use strict'

module.exports = angular.module('Workforce.foo', [])
    .config(($routeProvider) ->
      $routeProvider.when '/',
      templateUrl: 'app/foo/layout.html'
      controller: 'fooController'
      return
).controller('fooController', require('./fooController'))
