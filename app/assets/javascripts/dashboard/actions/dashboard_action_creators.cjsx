Marty = require('marty')
DashboardAPI = require('../sources/dashboard_api')
DashboardConstants = require('../constants/dashboard_constants')

DashboardActionCreators = Marty.createActionCreators(
  types:
    setSelectedBar: DashboardConstants.SELECT_BAR
    requestBars: DashboardConstants.REQUEST_BARS

  requestBars: () ->
    DashboardAPI.getAllBars()

  setSelectedBar: (barId) ->
    @dispatch(barId)
)

module.exports = DashboardActionCreators
