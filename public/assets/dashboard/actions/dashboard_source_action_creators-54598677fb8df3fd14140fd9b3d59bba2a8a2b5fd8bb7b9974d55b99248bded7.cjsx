Marty = require('marty')

DashboardConstants = require('../constants/dashboard_constants')

DashboardSourceActionCreators = Marty.createActionCreators(
  types:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION
    receiveRestaurants: DashboardConstants.RECEIVE_RESTAURANTS
    receiveMenu: DashboardConstants.RECEIVE_MENU

  receiveLocation: (location) ->
    @dispatch(location)

  receiveRestaurants: (restaurants) ->
    @dispatch(restaurants)

  receiveMenu: (menu) ->
    @dispatch(menu)

)


module.exports = DashboardSourceActionCreators
