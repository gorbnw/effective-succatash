class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user = current_user
    @business = Business.find(testimonial_params[:business_id])
    @testimonials = @business.testimonials
    @vote = Vote.new

      if (@testimonial.valid? && tag_params[:tags] != "")
        @testimonial.save
        @testimonial.tags << Tag.find(tag_params[:tags])
        if request.xhr?
          render 'businesses/_testimonial', locals: {testimonial: @testimonial, business: @business }, layout: false
        else
          redirect_to business_path(@business)
        end
      else
        @testimonial.valid?
        @testimonial.errors.add(:base, "Please select a tag")
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
