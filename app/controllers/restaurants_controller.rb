class RestaurantsController < ApplicationController
  def get_list
    postal_code = params[:postal_code].present? ? params[:postal_code] : LocationService.new.get_location_by_ip(request).postal_code
    price = params[:price]

    service_response = RestaurantService.new.search_by_postal_code(postal_code)

    if service_response.success
      render json: {
                 restaurants: service_response.entity,
                 postal_code: postal_code,
                 price: price
             }
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
