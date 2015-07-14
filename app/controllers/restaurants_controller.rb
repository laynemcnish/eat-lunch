class RestaurantsController < ApplicationController
  def get_list
    location = LocationService.new.get_location_by_ip(request)

    city = location.city

    restaurants = RestaurantService.new.search_by_city(city)

    render json: restaurants
  end

  def get_restaurant
    id = params[:id]

    restaurant = RestaurantService.new.search_by_business_id(id)

    render json: restaurant
  end
end