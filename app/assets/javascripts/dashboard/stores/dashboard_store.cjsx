Marty = require('marty')
DashboardConstants = require('../constants/dashboard_constants')
DashboardActionCreators = require('../actions/dashboard_action_creators')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')

DashboardStore = Marty.createStore(

  handlers:
    receiveLocation: DashboardConstants.RECEIVE_LOCATION

  getInitialState: () ->
    location: {zipcode:"HERE"}
    value: "Hello"

  receiveLocation: (location) ->
    @state.location = location
    @hasChanged()

  getLocation: () ->
    @state.location

  getValue: () ->
    @state.value

  sendForm: (data) ->
    creationRequest = $.ajax({
      type: 'POST',
      url: "/dashboard/submit",
      data: data
    })
)

module.exports = DashboardStore
