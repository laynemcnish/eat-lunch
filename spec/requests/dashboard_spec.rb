require "rails_helper"

describe "dashboard API" do
  describe "#index" do
    it "returns a successful response" do
      get "/"

      expect(response.status).to eq 200
    end
  end
end