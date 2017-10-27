require 'rails_helper'

describe Testimonial, type: :model do
  let!(:business){FactoryBot.create(:business)}
  let!(:testimonial){FactoryBot.create(:testimonial)}
  let!(:user){FactoryBot.create(:user)}
  let!(:tag1){FactoryBot.create(:tag, :tag1)}
  let!(:tag2){FactoryBot.create(:tag, :tag2)}
  let!(:vote1){Vote.create(user: user, testimonial: testimonial)}

  describe 'associations' do
    it 'has many tags' do
      testimonial.tags << [tag1, tag2]
      testimonial.save!
      expect(testimonial.tags).to eq [tag1, tag2]
    end

    it {is_expected.to have_many(:votes)}

    it {is_expected.to belong_to(:user)}

    it {is_expected.to belong_to(:business)}
  end

  describe '#count_praise' do
  end
end
