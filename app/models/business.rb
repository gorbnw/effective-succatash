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
    query = yelp_uri + I18n.transliterate(args)
    response = HTTParty.get(query, headers: {"Authorization" => ENV["YELP_TOKEN"] + " " + ENV["YELP_TOKEN_SECRET"] })
    response.parsed_response

  end

end
