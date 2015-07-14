require "rails_helper"

describe "restaurants API" do

  let(:search_response) { {
      "region" => {
          "span" => {"latitude_delta" => 0.05088225999999452, "longitude_delta" => 0.026115099999998392},
          "center" => {"latitude" => 40.031235300000006, "longitude" => -105.2702694}
      },
      "total" => 5770,
      "businesses" => [
          {
              "is_claimed" => true,
              "rating" => 5.0,
              "review_count" => 14,
              "name" => "Tacos Del Open",
              "url" => "http://www.yelp.com/biz/tacos-del-norte-boulder",
              "phone" => "7202614066",
              "snippet_text" => "This is a snippet",
              "categories" => [
                  ["Food Trucks", "foodtrucks"],
                  ["Mexican", "mexican"]
              ],
              "id" => "tacos-del-norte-boulder",
              "is_closed" => false
          },
          {
              "is_claimed" => true,
              "rating" => 5.0,
              "review_count" => 14,
              "name" => "Tacos Del closed",
              "is_closed" => true
          }
      ]
  }.to_json }

  let(:single_response) { {
      "is_claimed" => true,
      "rating" => 5.0,
      "review_count" => 14,
      "name" => "Tacos Del Open",
      "url" => "http://www.yelp.com/biz/tacos-del-norte-boulder",
      "phone" => "7202614066",
      "snippet_text" => "This is a snippet",
      "categories" => [
          ["Food Trucks", "foodtrucks"],
          ["Mexican", "mexican"]
      ],
      "id" => "tacos-del-norte-boulder",
      "is_closed" => false
  }.to_json }

  let(:accept_json) do
    {"Accept" => "application/json"}
  end

  describe "#get_list" do
    it "returns restaurants" do
      WebMock.stub_request(:get, "http://api.yelp.com/v2/search?limit=5&location=&term=food").
          to_return(:status => 200, :body => search_response, :headers => {})

      get "/restaurants/get_list.json", {}, accept_json

      expect(response.status).to eq 200

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to match_array [
                                      {:id => "tacos-del-norte-boulder",
                                       :name => "Tacos Del Open",
                                       :rating => 5.0,
                                       :review_count => 14,
                                       :url => "http://www.yelp.com/biz/tacos-del-norte-boulder",
                                       :phone => "7202614066",
                                       :snippet_text => "This is a snippet",
                                       :is_closed => false}
                                  ]
    end

    it "returns errors if present" do
      WebMock.stub_request(:get, "http://api.yelp.com/v2/search?limit=5&location=&term=food").
          to_return(:status => 500, :body => {}.to_json, :headers => {})

      get "/restaurants/get_list.json", {}, accept_json

      expect(response.status).to eq 404

      expect(JSON.parse(response.body)).to match_array (["Could not connect to Yelp API. :("])
    end
  end

  describe "#get_restaurant" do
    it "returns data for a particular restaurant" do
      WebMock.stub_request(:get, "http://api.yelp.com/v2/business/tacos-del-norte-boulder").
          to_return(:status => 200, :body => single_response, :headers => {})

      post "/restaurants/get_restaurant.json", {id: "tacos-del-norte-boulder"}, accept_json

      expect(response.status).to eq 200

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to eq ({:id => "tacos-del-norte-boulder",
                           :name => "Tacos Del Open",
                           :rating => 5.0,
                           :review_count => 14,
                           :url => "http://www.yelp.com/biz/tacos-del-norte-boulder",
                           :phone => "7202614066",
                           :snippet_text => "This is a snippet",
                           :is_closed => false})
    end

    it "returns errors if present" do
      WebMock.stub_request(:get, "http://api.yelp.com/v2/business/tacos-del-norte-boulder").
          to_return(:status => 500, :body => {}.to_json, :headers => {})

      post "/restaurants/get_restaurant.json", {id: "tacos-del-norte-boulder"}, accept_json

      expect(response.status).to eq 404

      expect(JSON.parse(response.body)).to match_array(["Could not connect to Yelp API. :("])
    end
  end
end