React = require('react')
Marty = require('marty')

DashboardStore = require('../stores/dashboard_store')
DashboardActionCreators = require('../actions/dashboard_action_creators')

DashboardState = Marty.createStateMixin(
  listenTo: DashboardStore
  getState: () ->
    return {
      restaurants: DashboardStore.getRestaurants(),
      randomRestaurant: DashboardStore.getRandomRestaurant(),
      showRestaurant: DashboardStore.getShowRestaurant(),
      showMenu: DashboardStore.getShowMenu(),
      menu: DashboardStore.getMenu()
  }
)


RestaurantsList= React.createClass
  mixins: [DashboardState]

  render: () ->
    className = if @state.showRestaurant then "active" else "hidden"
    className += " col-md-12"

    <div className={className} key="restaurantList">
      <h1 className="text-center">You will eat at:</h1>
      <div className="col-md-3"></div>
      <div className="col-md-6">
        <h2 className="text-center">{@state.randomRestaurant.name}</h2>
        <div className="col-md-4"></div>
        <div className="col-md-4">
          <div className="row">
            <img src={@state.randomRestaurant.rating_img_url} className="center-block"} />
          </div>
          <br/>
          <div className="row">
            <img className="restaurantImg" src={@state.randomRestaurant.image_url} className="center-block"} />
          </div>
          <br />
          <div className="row">
            <div className="text-center">
              <a href="https://www.google.com/maps/dir/Current+Location/#{@state.randomRestaurant.name}" target="_blank">Get Directions</a>
            </div>
          </div>
        </div>
        <div className="col-md-4"> </div>
      </div>
      <div className="col-md-3"> </div>
    </div>

module.exports = RestaurantsList
