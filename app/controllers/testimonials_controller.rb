class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user = current_user
    @business = Business.find(testimonial_params[:business_id])
    @testimonials = @business.testimonials
    @vote = Vote.new
    if @testimonial.save
      @testimonial.tags << Tag.find(tag_params[:tags])
      redirect_to business_path(@business)
    else
      render '/businesses/show'
    end

  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:description, :positive, :anonymous, :business_id)
  end

  def tag_params
    params.require(:testimonial).permit(:tags)
  end
end
