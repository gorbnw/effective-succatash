require 'oauth2'

class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def search
    render json: Yelp.client.search('San Francisco', {term: 'restaurants'})
  end

  def show
    @business = Business.find(params[:id])
    @testimonial = Testimonial.new
    @testimonials = @business.testimonials
    @vote = Vote.new

  end
end
