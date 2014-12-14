chai = require 'chai'
expect = chai.expect

address = 'Gartenstr. 1, 27251 Neuenkirchen'
expLocation =
  latlng: 'test'

GeoCodeModule = require './geocode.service'

describe 'The GeoCodeService', ->

  beforeEach ->
    @GeoCodeService = new GeoCodeModule

  it 'should be initialised', ->
    expect(@GeoCodeService).to.exist

  it 'should query an address async', (done) ->

    location = @GeoCodeService.getLocation(address)
    console.log location
    location.log('location')
    location.onEnd(onEnd)

    checkLocation = (location) ->
      expect(location, 'returned location differs').to.deep.equal(expLocation)
      done()

    # there is only one address, the returned stream should always end
    onEnd = () ->
      done()
