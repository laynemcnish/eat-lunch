class DashboardController < ApplicationController
  def index
    @location = LocationService.new.get_location_by_ip(request)

    respond_to do |format|
      format.html
      format.json { render json: @location.to_json }
    end
  end
end
