require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'users#new' do
    let!(:user){FactoryBot.create(:user)}
    before(:each) { get :new}

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
    it 'assigns all businesses' do
      expect(assigns[:user]).to eq User.new
    end
  end

  describe 'businesses#create' do
    let!(:user){FactoryBot.create(:user)}
    before(:each) { post :create, params: {username: user.username, email: user.email, encrypted_password: user.encrypted_password} }

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end

end
