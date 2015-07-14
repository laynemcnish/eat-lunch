class RestaurantsController < ApplicationController
  def get_list
    location = LocationService.new.get_location_by_ip(request)

    city = location.city

    service_response = RestaurantService.new.search_by_city(city)

    if service_response.success
      render json: service_response.entity
    else
      render json: service_response.errors, status: :not_found
    end
  end

  def get_restaurant
    id = params[:id]

    service_response = RestaurantService.new.search_by_business_id(id)

    if service_response.success
      render json: service_response.entity
    else
      render json: service_response.errors, status: :not_found
    end
  end
end