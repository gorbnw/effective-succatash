require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { FactoryBot.create(:user)}
  let(:business) { FactoryBot.create(:business)}
  let(:testimonial) { FactoryBot.build(:testimonial, :positive)}

  before do
    sign_in :user, create(:user)
  end

  describe 'votes#create' do
    before(:each) do
      testimonial.business_id = business.id
      testimonial.user_id = user.id
      testimonial.save
      post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} }
    end

    it 'returns a 302 status' do
      expect(response.status).to eq 302
    end

    it 'assigns the vote' do
      expect(assigns[:vote]).to be_an_instance_of(Vote)
    end

    it 'assigns the business' do
      expect(assigns[:business]).to eq business
    end
  end
end
