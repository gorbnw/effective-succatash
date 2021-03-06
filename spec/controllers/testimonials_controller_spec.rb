require 'rails_helper'

describe TestimonialsController, type: :controller do
  before(:each) do
    sign_in create(:user), scope: :user
    allow(ENV).to receive(:[]).with("YELP_TOKEN").and_return("yelp")
    allow(ENV).to receive(:[]).with("YELP_TOKEN_SECRET").and_return("secrets")
    allow(HTTParty).to receive(:get).and_return(resp_double)
  end

  describe "#create" do
    let!(:tag1) { Tag.create!(description: "Tag") }
    let!(:tag2) { Tag.create!(description: "Tag2") }

    context 'valid parameters are passed' do

      let!(:resp_double) { double(parsed_response: return_business) }
      let!(:yelp_id) { "safeway-marysville" }
      let!(:testimonial_params) { {params: {testimonial: {description: "Test description", positive: true, anonymous: false, yelp_id: "test"}, tags: {key1: tag1.id, key2: tag2.id} }} }

      before(:each) do
        post :create, testimonial_params
      end

      it 'returns a 302 status code' do
        expect(response.status). to eq 302
      end

      it 'redirects to business show page' do
        expect(response.location).to end_with "/businesses/test"
      end

      it 'assigns a business variable with yelp business information' do
        expect(assigns[:business]).to eq(resp_double.parsed_response)
      end

      it 'creates a new testimonial' do
        expect{ post :create, testimonial_params }.to change { Testimonial.all.length }.by 1
      end

      it 'creates a testimonial-tags association' do
        post :create, testimonial_params
        expect(Testimonial.last.tags).to eq [tag1, tag2]
      end
    end

    context 'valid parameters are not passed' do

      let!(:resp_double) { double(parsed_response: return_business) }
      let!(:yelp_id) { "safeway-marysville" }
      let!(:testimonial1) {FactoryBot.create(:testimonial, :positive)}
      let!(:testimonial2) {FactoryBot.create(:testimonial, :negative)}

      let!(:params) { {params: {testimonial: {yelp_id: "test"}}} }
      before(:each) do
        post :create, params
      end

      it 'returns a 200 status' do
        expect(response.status).to eq 200
      end

      it 'renders the business show page' do
        expect(response).to render_template(:show)
      end

      it 'assigns errors' do
        expect(assigns[:testimonial].errors.messages.count).to eq 4
      end

      it 'assigns a testimonials object' do
         expect(assigns[:testimonials]).to eq Testimonial.where(yelp_id: testimonial1.yelp_id)
      end
    end
  end

end
