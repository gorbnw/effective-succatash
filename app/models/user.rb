require 'httparty'
require 'uri'

class User < ApplicationRecord
  include HTTParty

  validates :username, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :testimonials
  has_many :votes


  def self.get_user_location
    google_coord_uri = "https://www.googleapis.com/geolocation/v1/geolocate?key=#{ENV['GOOGLE_MAPS_KEY']}"
    coordinates = HTTParty.post(google_coord_uri, :headers => { 'Content-Type' => 'application/json' }).parsed_response["location"]
    return '' if google_coord_uri == nil

    lat = coordinates["lat"]
    long = coordinates["lng"]
    location_city_uri = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{long}&key=#{ENV['GOOGLE_GEO_API']}"
    city = HTTParty.post(location_city_uri, :headers => { 'Content-Type' => 'application/json' }).parsed_response["results"][0]["address_components"][3]["long_name"].to_s
  end



end
