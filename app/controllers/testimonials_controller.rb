class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new()
    render "testimonials/new"
  end
end
