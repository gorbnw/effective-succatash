require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { FactoryBot.create(:user)}
  let(:testimonial) { FactoryBot.build(:testimonial, :positive)}

  before do
    sign_in create(:user), scope: :user
  end

  describe 'votes#create' do
    before(:each) do
      testimonial.user_id = user.id
      testimonial.save
    end

    context "when non-xhr request" do
      it 'returns a 302 status' do
        post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} }
        expect(response.status).to eq 302
      end

      it 'assigns the vote' do
        post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} }
        expect(assigns[:vote]).to be_an_instance_of(Vote)
      end

      it 'destroys the vote if the user has already voted on the testimonial yet' do
        post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} }
        expect{ post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} } }.to change { Vote.all.length }.by(-1)
      end

      it 'creates a new vote if the user has not voted on the testimonial yet' do
        expect{ post :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} } }.to change { Vote.all.length }.by(1)
      end

      it 'does not create a new vote if the user is not logged in' do
        sign_out(user)
        expect{ post :create, params: {vote: {testimonial_id: testimonial.id} } }.to change { Vote.all.length }.by(0)
      end
    end

    context "when xhr request" do
      # before(:each) { xhr :post, :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} } }

      # it "has a 200 status code" do
      #   xhr :post, :create, params: {current_user: user, vote: {testimonial_id: testimonial.id} }
      #   expect(response.status).to eq 200
      # end
    end
  end
end
