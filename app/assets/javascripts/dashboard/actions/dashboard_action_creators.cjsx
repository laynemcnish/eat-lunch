Marty = require('marty')
DashboardAPI = require('../sources/dashboard_api')
DashboardConstants = require('../constants/dashboard_constants')

DashboardActionCreators = Marty.createActionCreators(
  types:
    requestLocation: DashboardConstants.REQUEST_LOCATION

  requestLocation: () ->
    DashboardAPI.requestLocation()
)

module.exports = DashboardActionCreators
