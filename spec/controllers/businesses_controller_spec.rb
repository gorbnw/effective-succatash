require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  describe 'businesses#index' do
    let!(:business){FactoryBot.create(:business)}
    before(:each) { get :index}

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
    it 'assigns all businesses' do
      expect(assigns[:businesses]).to eq Business.all
    end
  end

  describe 'businesses#show' do
    let!(:business){FactoryBot.create(:business)}
    before(:each) { get :show, params: {id: business.id} }

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
    it 'assigns the business' do
      expect(assigns[:business]).to eq business
    end
  end

end
