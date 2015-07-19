Marty = require('marty')
DashboardAPI = require('../sources/dashboard_api')
DashboardStore = require('../stores/dashboard_store')
DashboardConstants = require('../constants/dashboard_constants')

DashboardActionCreators = Marty.createActionCreators(
  types:
    requestLocation: DashboardConstants.REQUEST_LOCATION
    requestRestaurants: DashboardConstants.REQUEST_RESTAURANTS

  requestLocation: () ->
    DashboardAPI.requestLocation()

  requestRestaurants: () ->
    DashboardStore.requestRestaurants()
)

module.exports = DashboardActionCreators
