chai = require 'chai'
expect = chai.expect

EventBusModule = require './data.eventBus.service'

describe 'The EventBusService', ->

  beforeEach ->
    @EventBusService = new EventBusModule

  it 'should be initialised', ->
    expect(@EventBusService).to.exist
    expect(@EventBusService.getEventBus() ).to.exist

