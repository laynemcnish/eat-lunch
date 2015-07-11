require "rails_helper"

describe "dashboard API" do

  let(:accept_json) do
    {"Accept" => "application/json" }
  end

  describe "#index" do
    it "returns a successful response" do
      get "/", {}, accept_json

      expect(response.status).to eq 200

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:ip]).to eq "127.0.0.1"
    end
  end
end