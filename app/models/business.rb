require 'httparty'
require 'uri'

class Business < ApplicationRecord
  include HTTParty

  def self.search_businesses(args)
    yelp_uri = "https://api.yelp.com/v3/businesses/search?"
    query = yelp_uri + URI.encode_www_form(args)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"] })
    response.parsed_response["businesses"]
  end

  def self.get_offset_businesses(args, value)
    yelp_uri = "https://api.yelp.com/v3/businesses/search?offset=#{value}&"
    query = yelp_uri + URI.encode_www_form(args)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"]})
    response.parsed_response['businesses']
  end

  def self.get_yelp_business_details(yelp_id)
    yelp_uri = "https://api.yelp.com/v3/businesses/"
    query = yelp_uri + I18n.transliterate(yelp_id)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"] })
    response.parsed_response
  end

  def self.check_GNR(business_details)
    latitude = business_details['coordinates']['latitude']
    longitude = business_details['coordinates']['longitude']
    name = business_details['name']
    gnr_biz = Business.search_businesses({'term' => name, 'latitude' => latitude, 'longitude' => longitude, 'attributes' => 'gender_neutral_restrooms'})
    all_biz = Business.search_businesses({'term' => name, 'latitude' => latitude, 'longitude' => longitude})
    if all_biz[0] == gnr_biz[0]
      "Yes"
    else
      "No/Unsure"
    end
  end



end
