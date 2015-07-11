require "rails_helper"

describe LocationService do
  let(:service) {LocationService.new}
  describe "#get_location_by_ip" do
    it "calls the geocoder using ip address from request" do
      #will have to figure out how to test this method that comes from the geocode gem
    end
  end
end