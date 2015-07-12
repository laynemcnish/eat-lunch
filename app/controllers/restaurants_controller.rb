class RestaurantsController < ApplicationController
  def show
    location = LocationService.new.get_location_by_ip(request)

    city = location.city

    restaurants = RestaurantService.new.search(city)

    render json: restaurants
  end
end