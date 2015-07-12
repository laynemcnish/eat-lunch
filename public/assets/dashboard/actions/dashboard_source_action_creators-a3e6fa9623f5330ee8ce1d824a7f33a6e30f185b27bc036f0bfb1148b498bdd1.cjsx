Marty = require('marty')

DashboardConstants = require('../constants/dashboard_constants')

DashboardSourceActionCreators = Marty.createActionCreators(
  types:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION

  receiveLocation: (location) ->
    @dispatch(location)
)

module.exports = DashboardSourceActionCreators
