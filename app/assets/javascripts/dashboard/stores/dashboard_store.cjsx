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
    randomRestaurant: {}
    showRestaurant: false
    value: "Hello"

  receiveLocation: (location) ->
    @state.location = location
    @hasChanged()

  receiveRestaurants: (restaurants) ->
    @state.restaurants = restaurants
    @pickRandomRestaurant(restaurants)
    @toggleRestaurantPanel()
    @hasChanged()

  toggleRestaurantPanel: () ->
    if @state.showRestaurant is false
      @state.showRestaurant = true
      @hasChanged()
    else
      @state.showRestaurant = false
      @hasChanged()

  getLocation: () ->
    @state.location

  getShowRestaurant: () ->
    @state.showRestaurant

  getRestaurants: () ->
    @state.restaurants

  getRandomRestaurant: () ->
    @state.randomRestaurant

  pickRandomRestaurant: (restaurants) ->
    @state.randomRestaurant = restaurants[Math.floor(Math.random() * restaurants.length)]

  getValue: () ->
    @state.value

)

module.exports = DashboardStore
