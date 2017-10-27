class TestimonialsController < ApplicationController
  def create
    testimonial = Testimonial.create(testimonial_params)
    @business = Business.find(testimonial_params[:business_id])
    redirect_to business_path(@business)
  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:description, :positive, :anonymous, :business_id)
  end
end
