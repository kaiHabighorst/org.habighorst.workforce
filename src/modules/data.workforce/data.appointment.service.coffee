'use strict'

# Test

### @ngInject ###
module.exports = (eventBusService)  ->
  readService = this

  # event handler
  executeAction = (event) ->
    event.execute()

  # Bacon Bus
  appointmentEventsBus = eventBusService.getEventBus()

  _appointmentListener = appointmentEventsBus.map( executeAction ).delay(0)
  readService.getAppointmentListener = () -> _appointmentListener

  readService.getEventBus = () -> appointmentEventsBus

  _appointmentsKeyList =  _appointmentListener.scan {}, (list, appointment) ->
    list[appointment.id] = appointment
    list

  _appointmentsListener = _appointmentsKeyList.map (appointments) ->
    list = []
    list.push appointment for key,appointment of appointments
    list


  readService.getAppointmentsListener = () -> _appointmentsListener

  return readService
