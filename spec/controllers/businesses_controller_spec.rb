require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  include BusinessesHelper

  before(:each) do
    allow(ENV).to receive(:[]).with("YELP_TOKEN").and_return("yelp")
    allow(ENV).to receive(:[]).with("YELP_TOKEN_SECRET").and_return("secrets")
  end

  xdescribe 'businesses#index' do
    let(:resp_double) { double(parsed_response: search_response) }
    let(:args) { {"term" => "hungryhut", "location" => "glencoe, al"} }
    before(:each) do
      allow(HTTParty).to receive(:get).and_return(resp_double)
    end

    before(:each) { get :index}

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end

  describe 'businesses#show' do
    let!(:resp_double) { double(parsed_response: return_business) }
    let!(:yelp_id) { "safeway-marysville" }
    let!(:testimonial_true) { FactoryBot.create(:testimonial, :positive, :safeway) }
    let!(:testimonial_false) { FactoryBot.create(:testimonial, :negative, :safeway) }

    before(:each) do
      allow(HTTParty).to receive(:get).and_return(resp_double)
      get :show, params: {id: "safeway-marysville"}
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end

    it 'assigns the business' do
      expect(assigns[:business]).to eq resp_double.parsed_response
    end

    it 'assigns the testimonial' do
      expect(assigns[:testimonial]).to be_instance_of(Testimonial)
    end

    it "assigns a collection of testimonials" do
      expect(assigns[:testimonials]).to eq Testimonial.where(yelp_id: "safeway-marysville")
    end

    it "assigns the top positive testimonial" do
      expect(assigns[:positive_testimonial]).to eq testimonial_true
    end

    it "assigns the top negative testimonial" do
      expect(assigns[:negative_testimonial]).to eq testimonial_false
    end

    it 'assigns the vote' do
      expect(assigns[:vote]).to be_instance_of(Vote)
    end

    it 'assigns tag counts' do
      expect(assigns[:tag_counts]).to eq tag_counts(Testimonial.where(yelp_id: "safeway-marysville"))
    end
  end

end
