require 'rails_helper'

describe TestimonialsController, type: :controller do
  let!(:business) { Business.create!(
      name: "The Happy Place",
      phone: "206-555-5555",
      address: "123 Broadway St"
    ) }
  it 'posts to the testimonials' do
    post :create, params: { testimonial: { description: "The bouncers here are rad!", positive: true, anonymous: false, business_id: business.id } }
    redirect_to route_to(:controller => :businesses, :action => :show)
  end
end
