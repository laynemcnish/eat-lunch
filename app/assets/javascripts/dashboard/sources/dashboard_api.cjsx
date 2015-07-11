Marty = require('marty')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')

DashboardAPI = Marty.createStateSource(
  getAllBars: () ->
    return new Promise((resolve) ->
      $.get('YELP_API', (result) =>
        DashboardSourceActionCreators.receiveBars(result)
        resolve()
      )
    )
)

module.exports = DashboardAPI
