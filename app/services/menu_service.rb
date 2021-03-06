class MenuService

  def initialize
    @conn = Faraday.new(url: "https://api.locu.com")
    @locu_api_key = ENV["LOCU_API_KEY"]
  end

  def get_menu_for_restaurant(name, postal_code, price_cap=100)
    response = conn.post do |req|
      req.url "/v2/venue/search"
      req.headers['Content-Type'] = 'application/json'
      req.body = { api_key: locu_api_key,
                  fields: ["name", "menus"],
                  venue_queries: [
                      {
                          name: name,
                          menus: { "$present" => true },
                          location: {
                              postal_code: postal_code.to_s,
                          }
                      }
                  ]
      }.to_json
    end
    if response.success?
      hash = JSON.parse(response.body, symbolize_names: true)
      ServiceResponse.build_success(consolidate(hash, price_cap))
    else
      ServiceResponse.build_error("Locu API could not be reached. :(")
    end

  end

  private

  attr_reader :conn, :locu_api_key

  def consolidate(hash, price_cap)
    menu_items = []
    if hash[:venues].length > 0
      hash[:venues][0][:menus][0][:sections].each do |section|
        section[:subsections].each do |sub|
          sub[:contents].each do |item|
            menu_items << {
                price: item[:price],
                name: item[:name],
                description: item[:description]
            } if item[:price].to_i < price_cap.to_i
          end
        end
      end
      {name: hash[:venues][0][:name], menu_items: menu_items}
    else
      ""
    end
  end

end
