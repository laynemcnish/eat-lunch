class DashboardController < ApplicationController
  def show
    location = LocationService.new.get_location_by_ip(request)

    render json: location, status: 200
  end

  def submit
    @address = params["address"]
    @price = params["price"]
    render :restaurant, address: @address, price: @price
  end

  def restaurant
  end
end
