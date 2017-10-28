class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
    @testimonial = Testimonial.new
    @testimonials = @business.testimonials
  end
end
