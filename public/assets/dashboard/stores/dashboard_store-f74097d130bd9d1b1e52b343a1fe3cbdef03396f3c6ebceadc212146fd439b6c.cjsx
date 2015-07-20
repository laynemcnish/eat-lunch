Marty = require('marty')
DashboardConstants = require('../constants/dashboard_constants')
DashboardActionCreators = require('../actions/dashboard_action_creators')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')
DashboardAPI = require('../sources/dashboard_api')

DashboardStore = Marty.createStore(

  handlers:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION
    receiveRestaurants: DashboardConstants.RECEIVE_RESTAURANTS
    receiveMenu: DashboardConstants.RECEIVE_MENU

  getInitialState: () ->
    location: {zipcode:""}
    price: "20"
    restaurants: []
    randomRestaurant: {}
    showRestaurant: false
    showMenu: false
    menu: ""

  receiveLocation: (location) ->
    @state.location = location
    @hasChanged()

  getPrice: () ->
    @state.price

  setPrice: (price) ->
    @state.price = price
    @hasChanged()

  receiveRestaurants: (restaurants) ->
    @state.restaurants = restaurants
    @pickRandomRestaurant(restaurants)
    @toggleRestaurantPanel()
    @hasChanged()

  receiveMenu: (menu) ->
    @state.menu = menu
    @toggleMenuPanel(menu)

  setMenu: (menu) ->
    @state.menu = menu
    @hasChanged()

  getMenu: () ->
    @state.menu

  toggleRestaurantPanel: () ->
    if @state.showRestaurant is false
      @state.showRestaurant = true
      @hasChanged()
    else
      @state.showRestaurant = false
      @hasChanged()

  toggleMenuPanel: (menu) ->
    if typeof menu isnt 'undefined'
      @state.showMenu = true
      @hasChanged()
    else
      @state.showMenu = false
      @hasChanged()

  getLocation: () ->
    @state.location

  getShowRestaurant: () ->
    @state.showRestaurant

  getShowMenu: () ->
    @state.showMenu

  getRestaurants: () ->
    @state.restaurants

  getRandomRestaurant: () ->
    @state.randomRestaurant

  pickRandomRestaurant: (restaurants) ->
    @state.randomRestaurant = restaurants[Math.floor(Math.random() * restaurants.length)]
    data = {postal_code: @state.randomRestaurant.postal_code, price: @state.price, name: @state.randomRestaurant.name}
    DashboardAPI.requestMenu(data)

)

module.exports = DashboardStore
