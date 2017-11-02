class BusinessesController < ApplicationController
  include BusinessesHelper

  def index
    session[:user_location] = User.get_user_location
    @businesses = nil
  end

  def search
    @business_details = {"term" => params[:search][:term], "location" => params[:search][:location]}
    flash.clear if params[:search][:location] != ""
    flash[:alert] = "Please enter a city to search" if params[:search][:location] == ""
    @businesses = Business.search_businesses(@business_details)
    render "businesses/index"
  end

  def show
    @business = Business.get_yelp_business_details(params[:id])
    @testimonial = Testimonial.new
    @testimonials = Testimonial.where(yelp_id: params[:id])
    @positive_testimonial = top_testimonial(@testimonials, true)
    @negative_testimonial = top_testimonial(@testimonials, false)
    @vote = Vote.new
    @tag_counts = tag_counts(@testimonials) # Uses the tag_counts method from the business helper module
  end

  def offset
    @offset = params[:search][:offset].to_i + 50
    business_details = {"term" => params[:search][:term], "location" => params[:search][:location]}
    @businesses = Business.get_offset_businesses(business_details, @offset)
    render 'businesses/index'
  end


end
