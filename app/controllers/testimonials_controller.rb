class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user = current_user

    @business = Business.get_yelp_business_details(testimonial_params[:yelp_id])
    @vote = Vote.new

    if (@testimonial.valid? && params[:testimonial][:tags].count != 0)
        @testimonial.save
        params[:testimonial][:tags].each do |tag|
          @testimonial.tags << Tag.find(tag)
        end
        if request.xhr?
          render 'businesses/_testimonial', locals: {testimonial: @testimonial, business: @business, vote: @vote }, layout: false
        else
          redirect_to "/businesses/#{testimonial_params[:yelp_id]}"
        end
    else
      @testimonial.valid?
      @testimonial.errors.add(:base, "Please select a tag")
      if request.xhr?
        @errors = @testimonial.errors
        render 'testimonials/_errors_form', layout: false, :status => 422
      else
        @testimonials = Testimonial.where(yelp_id: testimonial_params[:yelp_id])
        render '/businesses/show'
      end
    end

  end

  private

  def testimonial_params
    params.require(:testimonial).permit(:description, :positive, :anonymous, :yelp_id)
  end

  def tag_params
    params.permit(:tags)
  end
end
