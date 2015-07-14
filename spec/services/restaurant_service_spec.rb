require "rails_helper"

describe RestaurantService do

  let(:service) { RestaurantService.new }

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

  describe "#search_by_city" do
    it "returns a list of open restaurants" do


      WebMock.stub_request(:get, "http://api.yelp.com/v2/search?limit=5&location=Boulder&term=food").
          to_return(:status => 200, :body => search_response, :headers => {})

      result = service.search_by_city("Boulder")

      expect(result).to match_array [
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
  end

  describe "#search_by_business_id" do
    it "returns a businesses data" do
      WebMock.stub_request(:get, "http://api.yelp.com/v2/business/restaurant-id").
          to_return(:status => 200, :body => single_response, :headers => {})

      result = service.search_by_business_id("restaurant-id")

      expect(result).to eq ({:id => "tacos-del-norte-boulder",
                             :name => "Tacos Del Open",
                             :rating => 5.0,
                             :review_count => 14,
                             :url => "http://www.yelp.com/biz/tacos-del-norte-boulder",
                             :phone => "7202614066",
                             :snippet_text => "This is a snippet",
                             :is_closed => false})
    end
  end
end