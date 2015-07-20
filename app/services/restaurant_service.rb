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

  def search_by_postal_code(postal_code)
    params = {term: 'food',
              limit: 15
    }

    response = client.search(postal_code, params).businesses

    if response[0].respond_to?("name")
      result = consolidate(response)
      ServiceResponse.build_success(result)
    end

  rescue NoMethodError
    build_yelp_error
  end

  def search_by_business_id(business)
    response = client.business(business)

    if response.respond_to?("name")
      result = consolidate([response])[0]
      ServiceResponse.build_success(result)
    end

  rescue NoMethodError
    build_yelp_error
  end

  private

  def build_yelp_error
    ServiceResponse.build_error("Could not connect to Yelp API. :(")
  end

  def consolidate(response)
    response.map { |biz|
      {
          name: biz.respond_to?("name") ? biz.name : "nameless",
          rating: biz.respond_to?("rating") ? biz.rating : "unrated",
          review_count: biz.respond_to?("review_count") ? biz.review_count : "no reviews",
          url: biz.respond_to?("url") ? biz.url : "no url",
          phone: biz.respond_to?("phone") ? biz.phone : "no phone number",
          snippet_text: biz.respond_to?("snippet_text") ? biz.snippet_text : "no snippet",
          is_closed: biz.respond_to?("is_closed") ? biz.is_closed : "no hours info",
          id: biz.respond_to?("id") ? biz.id : "no biz id",
          image_url: biz.respond_to?("image_url") ? biz.image_url : "no biz image",
          rating_img_url: biz.respond_to?("rating_img_url") ? biz.rating_img_url : "no biz rating img_url",
          postal_code: biz.respond_to?("location") ? biz.location.postal_code : "no postal code"
      } }.reject { |biz| biz[:is_closed] == true }
  end

  attr_reader :client
end
