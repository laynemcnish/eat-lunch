React = require('react')

InfoForm = require('./info_form')

DashboardApp = React.createClass

  render: () ->
    <div className="col-md-12">
      <InfoForm />
    </div>

module.exports = DashboardApp
