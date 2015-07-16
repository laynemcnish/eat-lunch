class DashboardController < ApplicationController
  def show
    location = LocationService.new.get_location_by_ip(request)

    render json: location, status: 200
  end
end
