require 'rails_helper'

describe TestimonialsController, type: :controller do
  before(:each) do
    get :create
  end

  it 'renders the partial' do
    redirect_to url_for(:controller => :businesses, :action => :show)
    response.should render_template(:partial => 'new')
  end

  it 'assigns a testimonial object' do
    expect(assigns[:testimonial]).to be_a Testimonial
  end
end
