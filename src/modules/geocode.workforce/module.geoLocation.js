    'use strict';

    angular.module('org.habighorst.workforce.geoLocation', ['myApp.service.firebase'])

    .factory('locationService', ['syncData', '$q', '$timeout',
    function (syncData, $q, $timeout) {


    		var cachedAddresses = syncData('/cachedAddresses');

    		var queue = [];

    		// Amount of time (in milliseconds) to pause between each trip to the
    		// Geocoding API, which places limits on frequency.
    		var queryPause = 100;

    		/**
    		 * executeNext() - execute the next function in the queue.
    		 *                  If a result is returned, fulfill the promise.
    		 *                  If we get an error, reject the promise (with message).
    		 *                  If we receive OVER_QUERY_LIMIT, increase interval and try again.
    		 */
    		var executeNext = function () {
    			var task = queue[0],
    				geocoder = new google.maps.Geocoder();

    			geocoder.geocode({
    				address: task.address
    			}, function (result, status) {
    				if (status === google.maps.GeocoderStatus.OK) {
    					var locationQuery = {
    						location: {
    							lat: result[0].geometry.location.lat(),
    							lng: result[0].geometry.location.lng()
    						},
    						address_data: result[0].address_components
    					};

    					queue.shift();

    					cachedAddresses.$add({
    						address: task.address,
    						locationQuery: locationQuery
    					});

    					task.d.resolve(locationQuery.location);

    					if (queue.length) {
    						$timeout(executeNext, queryPause);
    					}
    				} else if (status === google.maps.GeocoderStatus.ZERO_RESULTS) {
    					queue.shift();
    					task.d.reject({
    						type: 'zero',
    						message: 'Zero results for geocoding address ' + task.address
    					});
    				} else if (status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
    					queryPause += 20;
    					$timeout(executeNext, queryPause);
    				} else if (status === google.maps.GeocoderStatus.REQUEST_DENIED) {
    					queue.shift();
    					task.d.reject({
    						type: 'denied',
    						message: 'Request denied for geocoding address ' + task.address
    					});
    				} else if (status === google.maps.GeocoderStatus.INVALID_REQUEST) {
    					queue.shift();
    					task.d.reject({
    						type: 'invalid',
    						message: 'Invalid request for geocoding address ' + task.address
    					});
    				}
    			});
    		};

    		return {
    			latLngForAddress: function (address) {
    				var d = $q.defer();

    				var addressFromCache = _.findWhere(cachedAddresses, {
    					address: address
    				})

    				if (addressFromCache) {
    					$timeout(function () {
    						d.resolve(addressFromCache.locationQuery.location);
    					});
    				} else {
    					queue.push({
    						address: address,
    						d: d
    					});

    					if (queue.length === 1) {
    						executeNext();
    					}
    				}

    				return d.promise;
    			}
    		};

    }]);