React = require('react')
Marty = require('marty')

DashboardStore = require('../stores/dashboard_store')
DashboardAPI = require('../sources/dashboard_api')
DashboardActionCreators = require('../actions/dashboard_action_creators')

DashboardState = Marty.createStateMixin(
  listenTo: DashboardStore
  getState: () ->
    return {
      location: DashboardStore.getLocation(),
      price: DashboardStore.getPrice(),
      hideForm: DashboardStore.getShowRestaurant()
  }
)

InfoForm = React.createClass
  mixins: [DashboardState]

  componentDidMount: () ->
    DashboardActionCreators.requestLocation()

  handleSubmit: (event) ->
    event.preventDefault()
    postal_code = @refs.postal_code.getDOMNode().value
    price = @refs.price.getDOMNode().value
    DashboardStore.setPrice(price)
    @refs.postal_code.getDOMNode().value = ''
    @refs.price.getDOMNode().value = ''
    DashboardAPI.sendForm({postal_code: postal_code, price: price})

  render: () ->
    className = if @state.hideForm then "hidden" else "active"
    className += " col-md-12"

    <div className={className} key="infoForm">
      <h1 className="text-center">Eat Lunch</h1>
        <div className="col-md-3"></div>
        <div className="col-md-6">
          <form className="info-form form-horizontal" onSubmit={@handleSubmit}>
            <div className="form-group">
              <label>Destination Postal code</label>
              <input className="form-control input-lg postal_code" type="text" name="postal_code" ref="postal_code" defaultValue="#{@state.location.zipcode}" />
            </div>
            <div className="form-group">
              <label>Maximum Price</label>
              <input className="form-control input-lg price" type="text" name="price" ref="price" defaultValue="#{@state.price}" />
            </div>
            <div className="form-group">
              <input type="submit" className="btn btn-default btn-lg" value="Choose My Lunch" onChange={@handleSubmit}/>
            </div>
          </form>
        </div>
      </div>


module.exports = InfoForm
