class BusinessesController < ApplicationController
  def index
    session[:user_location] = User.get_user_location
    @businesses = nil
  end

  def search
    business_details = {"term" => params[:search][:term], "location" => params[:search][:location]}
    flash.clear if params[:search][:location] != ""
    flash[:alert] = "Please enter a city to search" if params[:search][:location] == ""
    @businesses = Business.search_businesses(business_details)
    render "businesses/index"
  end

  def show
    @business = Business.get_yelp_business_details(params[:id])
    @testimonial = Testimonial.new
    @testimonials = Testimonial.where(yelp_id: params[:id])
    @positive_testimonial = top_testimonial(@testimonials, true)
    @negative_testimonial = top_testimonial(@testimonials, false)
    @vote = Vote.new
  end

  def top_testimonial(testimonials, boolean)
    testimonials.where(positive: boolean).reduce do |top_testimonial, testimonial|
      if testimonial.votes.count > top_testimonial.votes.count
        top_testimonial = testimonial
      end
      top_testimonial
    end
  end
end
