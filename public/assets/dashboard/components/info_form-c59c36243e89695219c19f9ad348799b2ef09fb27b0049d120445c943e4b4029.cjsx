React = require('react')
Marty = require('marty')

DashboardStore = require('../stores/dashboard_store')
DashboardActionCreators = require('../actions/dashboard_action_creators')

DashboardState = Marty.createStateMixin(
  listenTo: DashboardStore
  getState: () ->
    return {
      location: DashboardStore.getLocation()
  }
)

InfoForm = React.createClass
  mixins: [DashboardState]

  componentDidMount: () ->
    DashboardActionCreators.requestLocation()

  render: () ->
    <div className="col-md-12">
      <div className="center-block">
        <h1 className="text-center">Eat Lunch</h1>
        <h3 className="text-center">You are here:</h3>
        <h3 className="text-center">{@state.location.zipcode}</h3>
      </div>
    </div>

module.exports = InfoForm
