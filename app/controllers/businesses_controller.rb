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
    @vote = Vote.new
    @tags = @testimonials.map do |testimonial|
      testimonial.tags
    end
    @tags_normalized = []
    @tags.each do |tag|
      @tags_normalized.push(tag[0])
    end
    @tag_counts = []
    Tag.all.each do |tag|
      @tag_counts << @tags_normalized.count(tag)
    end
    
  end
end
