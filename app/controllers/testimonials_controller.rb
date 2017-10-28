class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @business = Business.find(testimonial_params[:business_id])
    @testimonials = @business.testimonials
    if @testimonial.save
      redirect_to business_path(@business)
    else
      render '/businesses/show'
    end

  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:description, :positive, :anonymous, :business_id)
  end
end
