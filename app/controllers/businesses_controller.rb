class BusinessesController < ApplicationController
  def index
    @businesses = nil
  end

  def search
    business_details = {"term" => params[:search][:term], "location" => params[:search][:location]}
    @businesses = Business.search_businesses(business_details)
    render "businesses/index"
  end

  def show
    business_details = params[:id]
    @business = Business.search_business(business_details)

    @testimonial = Testimonial.new
    @testimonials = Testimonial.find_by(business_id: params[:id])
    @vote = Vote.new
  end
end
