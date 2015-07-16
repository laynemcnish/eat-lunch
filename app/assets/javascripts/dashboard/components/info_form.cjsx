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

  handleSubmit: (event) ->
    event.preventDefault()
    city = @refs.city.getDOMNode().value
    price = @refs.price.getDOMNode().value
    @refs.city.getDOMNode().value = ''
    @refs.price.getDOMNode().value = ''
    data = {city: city, price: price}
    DashboardStore.sendForm(data)

  render: () ->
    <div className="col-md-12">
      <h1 className="text-center">Eat Lunch</h1>
        <div className="col-md-3"></div>
        <div className="col-md-6">
          <form className="info-form form-horizontal" onSubmit={@handleSubmit}>
            <div className="form-group">
              <label>City</label>
              <input className="form-control input-lg city" type="text" name="city" ref="city" defaultValue="#{@state.location.ip}" onChange={@handleCityChange} />
            </div>
            <div className="form-group">
              <label>Price</label>
              <input className="form-control input-lg price" type="text" name="price" ref="price" onChange={@handlePriceChange} />
            </div>
            <div className="form-group">
              <input type="submit" className="btn btn-default btn-lg" value="Choose My Lunch" onChange={@handleSubmit}/>
            </div>
          </form>
        </div>
      </div>

module.exports = InfoForm
