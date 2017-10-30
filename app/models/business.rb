require 'httparty'
require 'uri'

class Business < ApplicationRecord
  include HTTParty

  validates :name, :phone, :address, presence: true
  # has_many :testimonials

  def self.count_praise(yelp_business)
    count = Testimonial.where(business_id: yelp_business, positive: true).count
    return "#{count} user gave praise!" if count == 1
    return "#{count} users gave praise!" if count > 0
    "No praise for this business yet"

  end

  def self.count_criticism(yelp_business)
    count = Testimonial.where(business_id: yelp_business, positive: false).count
    return "#{count} user left criticism" if count == 1
    return "#{count} users left criticism" if count > 0
    "No criticism for this business yet"
  end

  def self.search_businesses(args)
    yelp_uri = "https://api.yelp.com/v3/businesses/search?"
    query = yelp_uri + URI.encode_www_form(args)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"] })
    response.parsed_response["businesses"]
  end

  def self.search_business(args)
    yelp_uri = "https://api.yelp.com/v3/businesses/"
    # query = yelp_uri + URI.encode_www_form(args)
    # business = args
    query = yelp_uri + args
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"] })
    response.parsed_response

  end

  ##only placed here for httparty use
  def self.get_user_location
    google_coord_uri = "https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_MAPS_KEY']}"
    coordinates = HTTParty.post(google_coord_uri, :headers => { 'Content-Type' => 'application/json' }).parsed_response["location"]
    lat = coordinates["lat"]
    long = coordinates["lng"]
    location_city_uri = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{long}&key=#{ENV['GOOGLE_GEO_API']}"

    city = HTTParty.post(location_city_uri, :headers => { 'Content-Type' => 'application/json' }).parsed_response["results"][0]["address_components"][3]["long_name"].to_s

  end

end
