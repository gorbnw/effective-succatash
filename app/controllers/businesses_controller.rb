class BusinessesController < ApplicationController
  def index
    @businesses = nil
  end

  def search
    hash = {"term" => params[:search][:term], "location" => params[:search][:location]}
    p @businesses = Business.search_business(hash)
    render "businesses/index"
  end

  def show
    @business = Business.find(params[:id])
    @testimonial = Testimonial.new
    @testimonials = @business.testimonials
    @vote = Vote.new

  end
end
