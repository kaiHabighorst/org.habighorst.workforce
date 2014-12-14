'use strict'

Bacon = require 'baconjs'

### @ngInject ###
module.exports = ()  ->
  eventBusService = this

  eventStore = []

  storeEvent = (event) ->
    event.date = new Date
    eventStore.push event
    event

  # Bacon Bus
  eventBus = new Bacon.Bus()
  eventBus.subscribe( storeEvent )

  eventBusService.getEventBus = () -> eventBus

  return eventBusService
