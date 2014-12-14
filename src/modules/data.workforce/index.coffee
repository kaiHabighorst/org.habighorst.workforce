'use strict'

module.exports = angular.module('Workforce.data', [])
  .factory('appointmentDataService', require('./data.appointment.service'))
  .factory('eventRepository', require('./data.event.repository'))
  .factory('eventBusService', require('./data.eventBus.service'))
