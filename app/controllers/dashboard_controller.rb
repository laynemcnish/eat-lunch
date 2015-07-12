class DashboardController < ApplicationController
  def index

  end

  def show
    @location = LocationService.new.get_location_by_ip(request)

    respond_to do |format|
      format.json { render json: @location.to_json }
    end
  end
end
