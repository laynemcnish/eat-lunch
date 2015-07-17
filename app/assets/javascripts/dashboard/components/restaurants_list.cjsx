React = require('react')
Marty = require('marty')

DashboardStore = require('../stores/dashboard_store')
DashboardActionCreators = require('../actions/dashboard_action_creators')

DashboardState = Marty.createStateMixin(
  listenTo: DashboardStore
  getState: () ->
    return {
      restaurants: DashboardStore.getRestaurants()
  }
)

RestaurantsList= React.createClass
  mixins: [DashboardState]

  componentDidMount: () ->
    DashboardActionCreators.requestRestaurants()

  render: () ->
    <div>
      <h1>Restaurants</h1>
      <p>{@state.restaurants} </p>

    </div>

module.exports = RestaurantsList
