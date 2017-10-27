require 'rails_helper'

describe TestimonialsController, type: :controller do
  it 'routes to the create testimonial page' do
    get :create
    expect(response.status).to eq(200)
  end
end
