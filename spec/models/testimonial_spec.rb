require 'rails_helper'

describe Testimonial, type: :model do
  let!(:business){FactoryBot.create(:business)}
  let!(:testimonial){FactoryBot.create(:testimonial)}
  let!(:user){FactoryBot.create(:user)}
  let!(:tag1){FactoryBot.create(:tag)}
  let!(:tag2){FactoryBot.create(:tag)}

  describe 'associations' do
    it 'has many tags' do
    end
    it 'has many tags' do
    end
    it 'has many votes' do
      expect(testimonial.votes).to eq 1
    end
    it 'belongs to a user'
    it 'belongs to a business'
  end

  describe '#count_praise' do
  end
end
