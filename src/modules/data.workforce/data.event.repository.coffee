'use strict'

### @ngInject ###
module.exports = (eventBusService)  ->
  eventRepository = this
  publishEventWrapper = (eventClass, params...) ->
    event = new eventClass params...
    eventBusService.getEventBus().push event
    event

  # read Service Definition
  eventRepository.appointment =
    create: (params...) ->
      publishEventWrapper(CreateAppointmentEvent, params...)
    delete: (params...) ->
      publishEventWrapper(DeleteAppointmentEvent, params...)

  return eventRepository

# EVENT CLASSES
class CreateAppointmentEvent
  execute: () ->
    app = new Appointment(@_appointmentData, @_id)
    app

  constructor: ( @_appointmentData, @_id ) ->
    throw new Error 'Appointment Data not defined'unless @_appointmentData
    @occuredAt =  new Date()

class DeleteAppointmentEvent
  execute: () ->
    @_appointment.delete()
    @_appointment

  constructor: ( @_appointment ) ->
    @occuredAt =  new Date()

# Classes
class Appointment
  getData: -> @data

  delete: ->
    @status.isDeleted = true

  constructor: (@data, @id) ->
    @status =
      isDeleted: false


