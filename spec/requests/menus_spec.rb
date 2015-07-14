require "rails_helper"

describe "Menus API" do

  let(:accept_json) do
    {"Accept" => "application/json" }
  end

  describe "POST /menus" do
    before do
      menu_response = {:status => "success",
                       :http_status => 200,
                       :venues =>
                           [{:menus =>
                                 [{:menu_name => "DAILY BRUNCH/LUNCH",
                                   :sections =>
                                       [{:subsections =>
                                             [{:subsection_name => "",
                                               :contents =>
                                                   [{:price => "6",
                                                     :type => "ITEM",
                                                     :name => "Daily Soup",
                                                     :description => "selection changes daily"},
                                                    {:price => "6",
                                                     :type => "ITEM",
                                                     :name => "Skordiala Dip",
                                                     :description => "potato, walnut, garlic, crostini"},
                                                    {:price => "6",
                                                     :type => "ITEM",
                                                     :name => "Fries",
                                                     :description => "aioli"}]}],
                                         :section_name => "SMALL PLATES‎"},
                                        {:subsections =>
                                             [{:subsection_name => "",
                                               :contents =>
                                                   [{:price => "8",
                                                     :type => "ITEM",
                                                     :name => "Arugula Salad",
                                                     :description => "fennel,‎ lemon olive oil, grana padano"},
                                                    {:price => "8",
                                                     :option_groups =>
                                                         [{:text => "Grilled Skewer",
                                                           :type => "OPTION_ADD",
                                                           :options =>
                                                               [{:price => "6", :name => "Chicken"},
                                                                {:price => "6", :name => "Lamb"}]}],
                                                     :type => "ITEM",
                                                     :name => "Endive Salad",
                                                     :description => "pine nuts, feta, red wine soaked currants"},
                                                    {:price => "9",
                                                     :type => "ITEM",
                                                     :name => "Roasted Beets",
                                                     :description => "blood orange vinaigrette, pickles, apples"}]}]}
                                       ],
                                   :currency_symbol => "$"}],
                             :locu_id => "317fc0495e8b4bfb1236",
                             :name => "Volta"}]}.to_json

      WebMock.stub_request(:post, "https://api.locu.com/v2/venue/search").
          with(:body => "{\"api_key\":\"e5d672eb88d62a5b9fbb66582841974eec87af13\",\"fields\":[\"name\",\"menus\"],\"venue_queries\":[{\"name\":null,\"menus\":{\"$present\":true},\"location\":{\"postal_code\":\"\"}}]}",
               :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.1'}).
          to_return(:status => 200, :body => menu_response, :headers => {})
    end
    it "returns aggregated menu data from a given restaurant name and zip code" do
      post "/menus/get_menu.json", {name: "Volta", postal_code: "80302"}.to_json, accept_json

      expect(response.status).to eq 200

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to eq (
                             {
                                 name: "Volta",
                                 menu_items: [{:price => "6",
                                               :name => "Daily Soup",
                                               :description => "selection changes daily"},
                                              {:price => "6",
                                               :name => "Skordiala Dip",
                                               :description => "potato, walnut, garlic, crostini"},
                                              {:price => "6",
                                               :name => "Fries",
                                               :description => "aioli"},
                                              {:price => "8",
                                               :name => "Arugula Salad",
                                               :description => "fennel,‎ lemon olive oil, grana padano"},
                                              {:price => "8",
                                               :name => "Endive Salad",
                                               :description => "pine nuts, feta, red wine soaked currants"},
                                              {:price => "9",
                                               :name => "Roasted Beets",
                                               :description => "blood orange vinaigrette, pickles, apples"}],
                             }
                         )
    end
  end
end