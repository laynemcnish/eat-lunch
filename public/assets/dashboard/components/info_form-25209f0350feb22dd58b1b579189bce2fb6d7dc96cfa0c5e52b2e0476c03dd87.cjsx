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
    @refs.postal_code.getDOMNode().value = ''
    @refs.price.getDOMNode().value = ''
    data = {postal_code: postal_code, price: price}
    DashboardAPI.sendForm(data)

  render: () ->
    className = if @state.hideForm then "hide" else "on"
    className += " col-md-12"

    <div className={className}>
      <h1 className="text-center">Eat Lunch</h1>
        <div className="col-md-3"></div>
        <div className="col-md-6">
          <form className="info-form form-horizontal" onSubmit={@handleSubmit}>
            <div className="form-group">
              <label>Zip code</label>
              <input className="form-control input-lg postal_code" type="text" name="postal_code" ref="postal_code" defaultValue={@state.location.ip} />
            </div>
            <div className="form-group">
              <label>Price</label>
              <input className="form-control input-lg price" type="text" name="price" ref="price" />
            </div>
            <div className="form-group">
              <input type="submit" className="btn btn-default btn-lg" value="Choose My Lunch" onChange={@handleSubmit}/>
            </div>
          </form>
        </div>
      </div>


module.exports = InfoForm
