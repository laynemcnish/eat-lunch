require "rails_helper"

describe RestaurantService do

  let(:service) {RestaurantService.new}

  describe "#search" do
    it "returns a list of open restaurants" do

      search_response =  {
          "region" =>{
          "span" =>{"latitude_delta" =>0.05088225999999452, "longitude_delta" =>0.026115099999998392},
          "center" =>{"latitude" =>40.031235300000006, "longitude" =>-105.2702694}
      },
          "total" =>5770,
          "businesses" =>[
          {"is_claimed" =>true, "rating" =>5.0, "review_count" =>14, "name" =>"Tacos Del Open", "url" =>"http://www.yelp.com/biz/tacos-del-norte-boulder", "phone" =>"7202614066", "snippet_text" =>"This toco stand is totally authentic, very affordable, and so tasty! \n\nI had 2 el pastor tacos, hot, and they were a great bar munchie. \n\nRight behind...", "categories" =>[["Food Trucks", "foodtrucks"], ["Mexican", "mexican"]], "display_phone" =>"+1-720-261-4066", "id" =>"tacos-del-norte-boulder", "is_closed" =>false, "location" =>{"city" =>"Boulder", "display_address" =>["4405 N Broadway", "Boulder, CO 80304"], "postal_code" =>"80304", "country_code" =>"US", "address" =>["4405 N Broadway"], "coordinate" =>{"latitude" =>40.0547703355551, "longitude" =>-105.282188951969}, "state_code" =>"CO"}},
          {"is_claimed" =>true, "rating" =>5.0, "review_count" =>14, "name" =>"Tacos Del Closed", "url" =>"http://www.yelp.com/biz/tacos-del-norte-boulder", "phone" =>"7202614066", "snippet_text" =>"This toco stand is totally authentic, very affordable, and so tasty! \n\nI had 2 el pastor tacos, hot, and they were a great bar munchie. \n\nRight behind...", "categories" =>[["Food Trucks", "foodtrucks"], ["Mexican", "mexican"]], "display_phone" =>"+1-720-261-4066", "id" =>"tacos-del-norte-boulder", "is_closed" =>true, "location" =>{"city" =>"Boulder", "display_address" =>["4405 N Broadway", "Boulder, CO 80304"], "postal_code" =>"80304", "country_code" =>"US", "address" =>["4405 N Broadway"], "coordinate" =>{"latitude" =>40.0547703355551, "longitude" =>-105.282188951969}, "state_code" =>"CO"}},
      ]
      }.to_json

      WebMock.stub_request(:get, "http://api.yelp.com/v2/search?limit=5&location=Boulder&term=food").
          to_return(:status => 200, :body => search_response, :headers => {})

      result = service.search("Boulder")

      expect(result).to match_array [
                                        {:name=>"Tacos Del Open",
                                         :rating=>5.0,
                                         :review_count=>14,
                                         :url=>"http://www.yelp.com/biz/tacos-del-norte-boulder",
                                         :phone=>"7202614066",
                                         :snippet_text=>"This toco stand is totally authentic, very affordable, and so tasty! \n\nI had 2 el pastor tacos, hot, and they were a great bar munchie. \n\nRight behind...",
                                         :is_closed=>false}
                                    ]
    end
  end
end