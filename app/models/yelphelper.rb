require 'httparty'
require 'uri'

class YelpHelper
  include HTTParty

  def self.search_business(args)
    yelp_uri = "https://api.yelp.com/v3/businesses/search?"
    query = yelp_uri + URI.encode_www_form(args)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["TOKEN"] + " " + ENV["TOKEN_SECRET"] })
    response.parsed_response["businesses"]
  end

end


# response=HTTParty.get("https://api.yelp.com/v3/businesses/search?term=papa%20johnss%20pizza&location=west%20seattle&limit=50", :headers => {"Authorization" => "Bearer gKiPQoj_l_a6NvrGddXFr-7doI4BGF8RmCOGZpgs_gWzeTkzT3VUOm5_WR5id0wmaLEQEMnaqlfhLrnfaAW3VBV0bqDZ5s9CpIxACswV4sRs0XrdwNBHrGTQwf30WXYx"})
