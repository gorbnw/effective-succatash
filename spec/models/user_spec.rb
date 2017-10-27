require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create(username: 'user' , email: 'user@user.com', encrypted_password: 'password', sign_in_count: 3)}

  describe 'attributes' do
    it 'has a username' do
      expect(user.username).to eq 'user'
    end

    it 'has an email' do
      expect(user.email).to eq 'user@user.com'
    end

    it 'has an encrypted_password' do
      expect(user.encrypted_password).to eq 'password'
    end

    it 'has a sign_in_count' do
      expect(user.sign_in_count).to eq 3
    end

  end
end
