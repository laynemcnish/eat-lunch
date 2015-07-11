Marty = require('marty')
DashboardConstants = require('../constants/dashboard_constants')
DashboardActionCreators = require('../actions/dashboard_action_creators')
DashboardSourceActionCreators = require('../actions/dashboard_source_action_creators')

moment = require('moment')
_ = require('lodash')

DashboardStore = Marty.createStore(

  handlers:
    selectBar: DashboardConstants.SELECT_BAR
    receiveBars: DashboardConstants.RECEIVE_BARS

  getInitialState: () ->
    bars: {}

  receiveBars: (bars) ->
    @state.bars = bars
    @hasChanged()

  getbars: () ->
    @state.bars
)

module.exports = DashboardStore
