class RestaurantService
  def initialize(
      client: Yelp::Client.new({consumer_key: ENV["YELP_CONSUMER_KEY"],
                                consumer_secret: ENV["YELP_CONSUMER_SECRET"],
                                token: ENV["YELP_TOKEN"],
                                token_secret: ENV["YELP_TOKEN_SECRET"]
                               })
  )
    @client = client
  end

  def search(city)
    params = { term: 'food',
               limit: 5
    }
    response = client.search(city, params).businesses

    consolidate(response)
  end
  private

  def consolidate(response)
    response.map {|biz|
      {
          name: biz.respond_to?("name") ? biz.name : "nameless",
          rating: biz.respond_to?("rating") ? biz.rating : "unrated",
          review_count: biz.respond_to?("review_count") ? biz.review_count : "no reviews",
          url: biz.respond_to?("url") ? biz.url : "no url",
          phone: biz.respond_to?("phone") ? biz.phone : "no phone number",
          snippet_text: biz.respond_to?("snippet_text") ? biz.snippet_text : "no snippet",
          is_closed: biz.respond_to?("is_closed") ? biz.is_closed : "no hours info",
      }}
  end

  attr_reader :client
end