'use strict'

module.exports = angular.module('Workforce.geoCode', [])
  .factory('geoCodeService', require('./geocode.service'))
