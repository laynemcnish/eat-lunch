Marty = require('marty')

DashboardConstants = require('../constants/dashboard_constants')

DashboardSourceActionCreators = Marty.createActionCreators(
  types:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION
    receiveRestaurants: DashboardConstants.RECEIVE_RESTAURANTS

  receiveLocation: (location) ->
    @dispatch(location)

  receiveRestaurants: (restaurants) ->
    @dispatch(restaurants)

)


module.exports = DashboardSourceActionCreators
