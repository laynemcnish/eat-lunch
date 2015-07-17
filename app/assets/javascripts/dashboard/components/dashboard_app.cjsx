React = require('react')

InfoForm = require('./info_form')
RestaurantsList = require('./restaurants_list')

DashboardApp = React.createClass

  render: () ->
    <div className="col-md-12">
      <InfoForm />
      <RestaurantsList />
    </div>

module.exports = DashboardApp
