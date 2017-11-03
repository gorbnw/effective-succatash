class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user = current_user

    @tags = []

    if params[:tags]
      params[:tags].each do |tag, value|
        @tags << Tag.find(value)
      end
    end

    @business = Business.get_yelp_business_details(params[:testimonial][:yelp_id])
    @vote = Vote.new

    if @testimonial.save && @tags.any? && @tags.count <= 5
        @tags.each do |tag|
          @testimonial.tags << tag
        end
        if request.xhr?
          render 'businesses/_testimonial', locals: {testimonial: @testimonial, vote: @vote }, layout: false
        else
          redirect_to "/businesses/#{testimonial_params[:yelp_id]}"
        end
    else
      @testimonial.errors.add(:base, "Please select a tag") if @tags.empty?
      @testimonial.errors.add(:base, "5 tag maximum") if @tags.count > 5
      if request.xhr?
        render '/_errors', layout: false, :status => 422, locals: {obj: @testimonial}
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

end
