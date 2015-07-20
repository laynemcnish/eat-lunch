Marty = require('marty')
DashboardAPI = require('../sources/dashboard_api')
DashboardStore = require('../stores/dashboard_store')
DashboardConstants = require('../constants/dashboard_constants')

DashboardActionCreators = Marty.createActionCreators(
  types:
    requestLocation: DashboardConstants.REQUEST_LOCATION
    sendForm: DashboardConstants.SEND_FORM
    requestMenu: DashboardConstants.REQUEST_MENU

  requestLocation: () ->
    DashboardAPI.requestLocation()

  requestMenu: () ->
    DashboardAPI.requestMenu()

  sendForm: () ->
    DashboardAPI.sendForm()
)

module.exports = DashboardActionCreators
