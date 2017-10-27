require 'rails_helper'

describe TestimonialsController, type: :controller do
  before(:each) do
    get :create
  end
  it 'routes to the create testimonial page' do
    expect(response.status).to eq(200)
  end

  it 'sets an instance of a testimonial object' do
    expect(assigns[:testimonial]).to be_a Testimonial
  end
end
