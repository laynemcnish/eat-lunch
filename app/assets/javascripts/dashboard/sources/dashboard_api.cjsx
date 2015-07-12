Marty = require('marty')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')

DashboardAPI = Marty.createStateSource(
  requestLocation: () ->
    return new Promise((resolve) ->
      $.get('/dashboard.json', (result) =>
        DashboardSourceActionCreators.receiveLocation(result.data)
        resolve()
      )
    )
)

module.exports = DashboardAPI
