class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
    @testimonials = @business.testimonials
    @vote = Vote.new
  end
end
