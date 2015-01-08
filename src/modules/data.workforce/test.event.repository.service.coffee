chai = require 'chai'
expect = chai.expect

category =
  add1: () -> 1
  addx: (x) -> x



EventRepositoryModule = require './data.event.repository.service'
EventBusModule = require './data.eventBus.service'

describe 'The EventRepository', ->

  beforeEach ->
    @EventBusService = new EventBusModule
    @EventRepository = new EventRepositoryModule(@EventBusService)

  it 'should be initialised', ->
    expect(@EventRepository).to.exist

  it 'should add a category', (done) ->
    @EventRepository.addEventCategory 'test', category
    expect(@EventRepository.test).to.exist
    expect(@EventRepository.test.add1).to.exist
    expect(@EventRepository.test.add1).to.be.a.function
    done()

  it 'should not overwrite categories', ->
    @EventRepository.addEventCategory 'test', category
    expect(@EventRepository.addEventCategory 'test', category).to.throw(Error)
