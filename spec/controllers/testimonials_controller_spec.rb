require 'rails_helper'

describe TestimonialsController, type: :controller do
  let!(:business) { Business.create!(
      name: "The Happy Place",
      phone: "206-555-5555",
      address: "123 Broadway St"
    ) }

  before do
    sign_in :user, create(:user)
  end

  let!(:tag) { Tag.create!(description: "Tag") }

  xit 'posts to the testimonials' do
    post :create, params: { testimonial: { description: "The bouncers here are rad!", positive: true, anonymous: false, business_id: business.id, tags: tag.id } }
    redirect_to route_to(:controller => :businesses, :action => :show)
  end

  xit 'creates a new testi
  monial after posting' do
    expect{ post :create, params: { testimonial: { description: "The bouncers here are rad!", positive: true, anonymous: false, business_id: business.id, tags: tag.id } } }.to change{ Testimonial.all.length }.by(1)
  end

  xit 'creates an association between tags and the testimonial after posting' do
    post :create, params: { testimonial: { description: "The bouncers here are rad!", positive: true, anonymous: false, business_id: business.id, tags: tag.id } }
    expect(Testimonial.last.tags).to include(tag)
  end
end
