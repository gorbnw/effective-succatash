class TestimonialsController < ApplicationController
  def create
    @testimonial = Testimonial.new()
    
  end
end
