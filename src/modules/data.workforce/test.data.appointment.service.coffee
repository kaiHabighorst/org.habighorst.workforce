chai = require 'chai'
expect = chai.expect


appointments = [
  address: 'Gartenstr. 1, 27251 Neuenkirchen'
  due: new Date()
  appointed: new Date()

  customer:
    name: 'Kai Habighorst'

  employee:
    name: 'Fritz Habighorst'

]


AppointmentsServiceModule = require './data.appointment.service'
EventRepositoryModule = require './data.event.repository.service'
EventBusModule = require './data.eventBus.service'

describe 'The AppointmentsDataService', ->

  beforeEach ->
    @EventBusService = new EventBusModule
    @AppointmentsService = new AppointmentsServiceModule(@EventBusService)
    @EventRepository = new EventRepositoryModule(@EventBusService)

  it 'should be initialised', ->
    expect(@AppointmentsService).to.exist
    expect(@AppointmentsService.getAppointmentListener() ).to.exist
    expect(@AppointmentsService.getAppointmentsListener() ).to.exist
    expect(@EventRepository).to.exist
    expect(@EventRepository.appointment).to.exist

  it 'should create & delete appoinments', (done) ->
    appointmentsListener = @AppointmentsService.getAppointmentsListener()

    numberOfAppointments = 0
    event = @EventRepository.appointment

    appointmentsListener.onValue (apps) ->
      if not numberOfAppointments > 2
        expect(apps.length).to.equal(numberOfAppointments)

      if numberOfAppointments is 2
        delet = event.delete(apps[0])

      if numberOfAppointments is 3
        expect(apps[0].status.isDeleted).to.equal(true)
        done()

      numberOfAppointments += 1

    create = event.create( appointments[0], 'test1')
    expect(create).to.exist

    create = event.create( appointments[0], 'test2')
    expect(create).to.exist
