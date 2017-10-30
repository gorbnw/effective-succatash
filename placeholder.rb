class TestimonialsController < ApplicationController
  def create
  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:description, :positive, :anonymous, :business_id)
  end

  def tag_params
    params.require(:testimonial).permit(:tags)
  end
end
