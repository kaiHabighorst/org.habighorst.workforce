'use strict'

Bacon = require 'baconjs'
GeoCodeModule = require 'node-geocoder'

GeoCode = GeoCodeModule.getGeoCoder('google','https')

### @ngInject ###
module.exports = ()  ->
  geoService = this

  _queryGoogleForAddress = (addressObj) ->
    console.log 'query address'
    Bacon.fromNodeCallback(GeoCode.geocode, addressObj.address)
      .map (loc) ->
         addressObj.location = loc
         addressObj

  # internal buffering of queries, to prevent to many requests to google API
  _googleQueryBus = new Bacon.Bus()
  _throttledGoogleQuery = _googleQueryBus.throttle(100).flatMap _queryGoogleForAddress
  _throttledGoogleQuery.log 'throttled'

  geoService.getLocation = (address) ->
    addressObj =
      address: address
      id: 'test'

    _googleQueryBus.push addressObj
    _googleQueryBus.push addressObj

    _queryGoogleForAddress(addressObj)
    _googleQueryBus.push(addressObj)

  return geoService
