Marty = require('marty')
DashboardConstants = require('../constants/dashboard_constants')
DashboardActionCreators = require('../actions/dashboard_action_creators')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')

DashboardStore = Marty.createStore(

  handlers:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION
    receiveRestaurants: DashboardConstants.RECEIVE_RESTAURANTS

  getInitialState: () ->
    location: {zipcode:"HERE"}
    restaurants: []
    value: "Hello"

  receiveLocation: (location) ->
    @state.location = location
    @hasChanged()

  receiveRestaurants: (restaurants) ->
    @state.restaurants = restaurants
    @hasChanged()

  getLocation: () ->
    @state.location

  getRestaurants: () ->
    @state.restaurants

  getValue: () ->
    @state.value

  sendForm: (data) ->
    return new Promise((resolve) ->
      $.post("/restaurants/get_list.json", data, (response) =>
        console.log(response)
        DashboardSourceActionCreators.receiveRestaurants(response.restaurants)
        resolve())
      )

)

module.exports = DashboardStore
