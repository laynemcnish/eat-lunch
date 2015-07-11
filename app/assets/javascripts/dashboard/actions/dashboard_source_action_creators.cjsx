Marty = require('marty')

DashboardConstants = require('../constants/dashboard_constants')

DashboardSourceActionCreators = Marty.createActionCreators(
  types:
    receiveBars: DashboardConstants.RECEIVE_BARS

  receiveBars: (bars) ->
    @dispatch(bars)
)

module.exports = DashboardSourceActionCreators
