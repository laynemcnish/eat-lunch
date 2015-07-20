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

  sendForm: (data) ->
    return new Promise((resolve) ->
      $.post("/restaurants/get_list.json", data, (response) =>
        DashboardSourceActionCreators.receiveRestaurants(response.restaurants)
        resolve())
      )
)

module.exports = DashboardAPI
